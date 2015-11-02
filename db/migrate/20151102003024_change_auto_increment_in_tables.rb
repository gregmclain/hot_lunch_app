class ChangeAutoIncrementInTables < ActiveRecord::Migration
  def change
      ActiveRecord::Base.connection.execute(
          "ALTER SEQUENCE students_id_seq RESTART WITH 810"
      )

      ActiveRecord::Base.connection.execute(
          "ALTER SEQUENCE users_id_seq RESTART WITH 410"
      )

      ActiveRecord::Base.connection.execute(
          "ALTER SEQUENCE orders_id_seq RESTART WITH 1010"
      )
  end
end

