class OrdersController < ApplicationController
  before_action :set_student
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = @student.orders.all
  end

  def show
    @order = @student.orders.find(params[:id])
  end

  def new
    @order = @student.orders.new
    @menu = Menu.find(15)
  end

  def edit
  end

  def create
    @order = @student.orders.new(params[:order])

    if @order.save
      redirect_to [@student, @order], notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def update
  end

  def destroy
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
    params.require(:order).permit(:order_date, :student_id)
  end

end

