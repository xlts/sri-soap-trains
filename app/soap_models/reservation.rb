class Reservation < WashOut::Type
	attr_accessor :connection, :wallet, :confirmation_code
	map amount: :double, confirmation_code: :string, connection: Connection

	def initialize(wallet, connection)
		@wallet = wallet
		@connection = connection
	end

	def assign_confirmation_code
		confirmation_code = SecureRandom.hex
	end

	def can_be_paid?
		wallet.balance >= connection.price
	end
end