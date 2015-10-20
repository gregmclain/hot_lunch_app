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
  end

  def edit
    @menu = Menu.find_by(menu_date: @order.order_date)
    set_menu_items
  end

  def create
    @order = @student.orders.new(order_params)

    if params.has_key?(:main)
      redirect_to new_student_order_path(@student, :menu_date => @order.order_date), notice: 'No items were selected.'
    elsif @order.save
      redirect_to @student, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def update
    if params.has_key?(:main)
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
    @main_dishes = @menu.items.select{|item| item.category == "Main" }
    @sides = @menu.items.select{|item| item.category == "Side" }
    @desserts = @menu.items.select{|item| item.category == "Dessert" }
  end

end

