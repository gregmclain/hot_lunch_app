class OrdersController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_student
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :correct_user

  def index
    @orders = @student.orders.all
  end

  def show
  end

  def new
    @order = @student.orders.new
    @order.entree_quantity = 1
    @order.order_date = params[:menu_date]
    @menu = Menu.find_by(menu_date: params[:menu_date])
    set_menu_items
    if Deadline.passed_deadline?(@order.order_date.month, Time.current)
        redirect_to @student, notice: 'Ordering is complete for this month.'
    end
  end

  def edit
    @menu = Menu.find_by(menu_date: @order.order_date)
    set_menu_items
    check_date_range
  end

  def create
    @order = @student.orders.new(order_params)
    @order.calculate_and_store_price

    if @order.save
      Order::adjust_orders_for_discount(@student,@order.order_date.month)
      redirect_to student_path(@student,:month => @order.order_date.month), notice: 'Order was successfully created.'
    else
      redirect_to new_student_order_path(@student, :menu_date => @order.order_date), notice: 'Please select one of each option.'
    end
  end

  def update
    @order.assign_attributes(order_params)
    @order.calculate_and_store_price

    if @order.update_attributes(order_params)
      Order::adjust_orders_for_discount(@student,@order.order_date.month)
      redirect_to student_path(@student,:month => @order.order_date.month), notice: 'Order was successfully updated.'
    else
      redirect_to edit_student_order_path(@student, :menu_date => @order.order_date), notice: 'Please select one of each option.'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @month = @order.order_date.month
    @order.destroy
    Order::adjust_orders_for_discount(@student,@month)
    redirect_to student_path(@student,:month => @month), notice: 'Order was deleted.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:order_date, :student_id, :entree_quantity, :entree,
                                  :side, :dessert, :price, :notes)
  end

  def correct_user
    @student = current_user.students.find_by(id: params[:student_id])
    redirect_to root_url if @student.nil?
  end

  def set_menu_items
    @entrees = @menu.items.select{|item| item.category == "Entree" }
    @sides = @menu.items.select{|item| item.category == "Side" }
    @desserts = @menu.items.select{|item| item.category == "Dessert" }
  end

  def check_date_range
    if Deadline.passed_deadline?(@order.order_date.month, Time.current)
      redirect_to student_order_path(@student, @order)
    end
  end

end

