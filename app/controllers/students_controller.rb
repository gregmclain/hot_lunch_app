class StudentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  def show
    if params.has_key?(:month)
      @menus = Menu.where('extract(month from menu_date) = ?', params[:month])
      @total = Order.where('extract(month from order_date) = ? AND student_id = ?', params[:month], @student.id).sum(:price)
      @month = params[:month].to_i
      respond_to do |format|
        format.html { render "show_student_month.html.erb" }
        format.pdf { render :layout => false }
      end
    else
      @months = Menu.all.order(:menu_date).map { |d| d.menu_date.strftime('%B')}.uniq
    end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = current_user.students.build(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Student was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find_by_id(params[:id])

      redirect_to current_user if @student.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name,:last_name, :grade)
    end

  def correct_user
    @student = current_user.students.find_by(id: params[:id])
    redirect_to root_url if @student.nil?
  end
end
