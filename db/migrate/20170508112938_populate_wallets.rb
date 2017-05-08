class PopulateWallets < ActiveRecord::Migration[5.0]
  def change
  	Wallet.create!([{balance: 10.51, access_token: "abc123"}, {balance: 22.65, access_token: "qwe123"}, {balance: 56.41, access_token: "ewq123"}])
  end
end
