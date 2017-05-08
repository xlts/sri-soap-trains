class ConnectionsController < ApplicationController
	soap_service namespace: 'urn:Connections'

	soap_action 'get_connections', args: { connection_request: ConnectionRequest }, return: { connections: [Connection] }
	def get_connections
		render soap: [Connection.find_by_connection_request(params[:connection_request])]
	end


	soap_action 'reserve_connection', args: { connection: Connection, access_token: :string }, return: { reservation: Reservation }
	def reserve_connection
		wallet = Wallet.find_by(access_token: params[:access_token])
		connection = Connection.new(params[:connection])
		reservation = Reservation.new(wallet: wallet, connection: connection)
		if reservation.can_be_paid?
			reservation.assign_confirmation_code
			wallet.update!(balance: wallet.balance - connection.price)
			render soap: reservation
		else
			raise InsufficientBalance.new
		end
	end
end
