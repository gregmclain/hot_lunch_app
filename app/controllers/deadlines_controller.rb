class DeadlinesController < ApplicationController

  def index
    @deadlines = Deadline.all
  end

  def show
  end

  def new
    @deadline = Deadline.new
  end

  def edit
  end

  def create
    @deadline = Deadline.new(deadline_params)

    if @deadline.save
      redirect_to @deadline, notice: 'Deadline was successfully created.'
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_params
    params.require(:deadline).permit!
  end
end