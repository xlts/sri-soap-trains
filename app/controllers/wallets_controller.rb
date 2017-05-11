class WalletsController < ApplicationController
	soap_service namespace: 'urn:Wallet'

	before_action :get_wallet, only: [:show_wallet, :top_up]

	soap_action 'show_wallet', args: { access_token: :string }, return: { wallet: SoapWallet }
	def show_wallet
		render soap: { wallet: serialized_wallet }
	end

	soap_action 'top_up', args: { access_token: :string, amount: :double }, return: { wallet: SoapWallet }
	def top_up
		raise SOAPError.new("Amount must be a positive number") if params[:amount] < 0
		@wallet.update(balance: @wallet.balance + params[:amount])
		render soap: { wallet: serialized_wallet }
	end

private

	def get_wallet
		@wallet = Wallet.find_by(access_token: params[:access_token])
		raise SOAPError.new("Wallet not found") unless @wallet
	end

	def serialized_wallet
		SoapWallet.new(@wallet).serialized
	end
end