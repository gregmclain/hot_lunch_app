class MilksController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_student
  before_action :set_milk, only: [:show, :edit, :update, :destroy]
  before_action :correct_user

  def show
  end

  def new
    @milk = Milk.new
    @milk.month = params[:month]
    if Deadline.passed_deadline?(@milk.month, Time.current)
      redirect_to @student, notice: 'Ordering is complete for this month.'
    end
  end

  def edit
    if Deadline.passed_deadline?(@milk.month, Time.current)
      redirect_to @student, notice: 'Ordering is complete for this month.'
    end
  end

  def create
    @milk = @student.milks.new(milk_params)

    if @milk.save
      redirect_to student_path(@student,:month => @milk.month), notice: 'Milk was successfully ordered.'
    else
      # redirect_to new_student_order_path(@student, :menu_date => @order.order_date), notice: 'Please select one of each option.'
    end
  end

  def update
    @milk.assign_attributes(milk_params)

    if @milk.update_attributes(milk_params)
      redirect_to student_path(@student,:month => @milk.month), notice: 'Milk order was successfully updated.'
    else
      # redirect_to edit_student_order_path(@student, :menu_date => @order.order_date), notice: 'Please select one of each option.'
    end
  end

  def destroy
    @milk = Milk.find(params[:id])
    @month = @milk.month
    @milk.destroy
    redirect_to student_path(@student,:month => @month), notice: 'Milk order was deleted.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_milk
    @milk = Milk.find(params[:id])
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def milk_params
    params.require(:milk).permit(:student_id, :month, :milk_type)
  end

  def correct_user
    @student = current_user.students.find_by(id: params[:student_id])
    redirect_to root_url if @student.nil?
  end

end
