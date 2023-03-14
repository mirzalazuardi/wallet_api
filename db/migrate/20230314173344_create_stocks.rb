class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :identifier
      t.string :last_price
      t.datetime :last_update_time

      t.timestamps
    end
  end
end
