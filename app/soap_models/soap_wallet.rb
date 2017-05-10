class SoapWallet < WashOut::Type
	delegate :balance, to: :@wallet

	map balance: :double

	def initialize(wallet)
		@wallet = wallet
	end
end