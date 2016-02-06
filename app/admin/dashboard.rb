ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do

      (Date.today..(1.week.from_now).to_date).each do |date|
        entrees = Order.where(:order_date => date).group(:entree).count
        sides = Order.where(:order_date => date).group(:side).count
        desserts = Order.where(:order_date => date).group(:dessert).count
        orders = entrees.merge(sides)
        full_orders = orders.merge(desserts)

        # Create a panel for the date if there are orders for that day
        panel date do
          ul do
            full_orders.each do |item, value|
              li "#{item}  => #{value}"
            end
          end
        end if !full_orders.empty?

      end
    end
  end
end