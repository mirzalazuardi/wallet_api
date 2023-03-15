class ChangeColumnFromStock < ActiveRecord::Migration[7.0]
  def change
    remove_column :stocks, :last_price
    remove_column :stocks, :last_update_time
  end
end
