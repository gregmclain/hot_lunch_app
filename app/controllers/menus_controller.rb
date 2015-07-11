class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = Menu.all
  end

  def show
  end

  def new
    @menu = Menu.new
  end

  def edit
  end

  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      redirect_to @menu, notice: 'Menu was successfully created.'
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
  def set_menu
    @menu = Menu.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_params
   # params.require(:menu).permit(:menu_date, items_attributes: [:name,
    #                                                           :category, :description])
#    params.require(:goal).permit(milestones_attributes: [milestone_programs_attributes: [program_attributes:[]]])

    params.require(:menu).permit!
  end
end

