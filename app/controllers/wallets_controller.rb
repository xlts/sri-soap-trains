class WalletsController < ApplicationController
	soap_service namespace: 'urn:Wallets'

	soap_action 'get_balance', args: { access_token: :string }, return: { wallet: Wallet }
	def get_balance
		render soap: Wallet.find_by(access_token: params[:access_token])
	end
end