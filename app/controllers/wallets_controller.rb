class WalletsController < ApplicationController
	soap_service

	soap_action 'get_balance', args: { access_token: :string }, return: { wallet: SoapWallet }
	def get_balance
		wallet = Wallet.find_by(access_token: params[:access_token])
		render soap: { wallet: SoapWallet.new(wallet).serialized }
	end
end