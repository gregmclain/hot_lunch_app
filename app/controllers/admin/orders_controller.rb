class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  def index
      @orders = Order.all

      respond_to do |format|
        format.html
        format.csv { send_data @orders.to_csv }
      end
  end

end
