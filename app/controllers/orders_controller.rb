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
    @order = @student.orders.new(order_params)

    if @order.save
      redirect_to [@student, @order], notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def update
    # make sure that item_ids are in the param hash even if none of the checkboxes are checked
    params[:order][:item_ids] ||= []
  end

  def destroy
  end

  def menu_info
    # Create a blank order for the form to default the checkboxes
    @order = Order.new

    @date = Date.new params[:year].to_i, params[:month].to_i, params[:day].to_i

    @menu = Menu.find_by(:menu_date => @date)

    # renders the given partial with the menu found above and returns in JSON format
    render json: {
               content: render_to_string({
                                             partial: 'menu_info',
                                             layout: nil
                                         })
           }
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

end

