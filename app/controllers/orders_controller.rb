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
    @order.order_date = params[:menu_date]
    @menu = Menu.find_by(menu_date: params[:menu_date])
    set_menu_items
    if @order.order_date.month == Date.today.month
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

    if params.has_key?(:entree)
      redirect_to new_student_order_path(@student, :menu_date => @order.order_date), notice: 'No items were selected.'
    elsif @order.save
      redirect_to @student, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def update
    @order.assign_attributes(order_params)
    @order.calculate_and_store_price
    if params.has_key?(:entree)
       destroy
    elsif @order.update_attributes(order_params)
      redirect_to @student, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to @student, notice: 'Order was deleted.'
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
    #params.require(:order).permit(:order_date, :student_id)
    params.require(:order).permit!
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
    if @order.order_date.month == Date.today.month
      redirect_to student_order_path(@student, @order)
    end
  end

end

