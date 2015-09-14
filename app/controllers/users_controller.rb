class UsersController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def show
    @students = current_user.students.order('first_name ASC')
  end

end
