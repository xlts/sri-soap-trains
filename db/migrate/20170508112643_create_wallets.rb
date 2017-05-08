class CreateWallets < ActiveRecord::Migration[5.0]
  def change
    create_table :wallets do |t|
    	t.string :access_token
    	t.decimal :balance

    	t.timestamps null: false
    end
  end
end
