class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all

    respond_to do |format|
      format.html
      format.csv { send_data @orders.to_csv }
    end
  end

end
