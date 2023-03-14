class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.float :balance, default: 0.0
      t.references :ownable, polymorphic: true

      t.timestamps
    end
  end
end
