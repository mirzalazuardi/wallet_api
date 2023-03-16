class CreateDealings < ActiveRecord::Migration[7.0]
  def change
    create_table :dealings do |t|
      t.references :wallet, null: false, foreign_key: true
      t.integer :source_wallet_id
      t.integer :target_wallet_id
      t.float :amount
      t.string :type

      t.timestamps
    end
  end
end
