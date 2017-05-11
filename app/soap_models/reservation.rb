class Reservation < WashOut::Type
	attr_accessor :connection, :wallet, :confirmation_code

	delegate :price, to: :@connection

	map price: :double, confirmation_code: :string, connection: Connection

	def initialize(wallet:, connection:)
		@wallet = wallet
		@connection = connection
	end

	def assign_confirmation_code
		@confirmation_code = SecureRandom.hex
	end

	def can_be_paid?
		wallet.balance >= price
	end
end
