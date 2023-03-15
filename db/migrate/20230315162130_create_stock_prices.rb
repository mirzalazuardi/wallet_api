class CreateStockPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_prices do |t|
      t.references :stock, null: false, foreign_key: true
      t.float :price
      t.datetime :update_time

      t.timestamps
    end
  end
end
