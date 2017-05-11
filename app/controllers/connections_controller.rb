class ConnectionsController < ApplicationController
	soap_service namespace: 'urn:Connections'

	before_action :get_wallet_and_connection, only: :reserve_connection
	
	soap_action 'get_connections', args: { connection_request: ConnectionRequest }, return: { connections: [Connection] }
	def get_connections
		connections = Connection.find_by_connection_request(ConnectionRequest.new(connection_request_params))
		if connections.any?
			render soap: { connections: connections.map(&:serialized) }
		else
			raise SOAPError.new("Connections could not be found")
		end
	end

	soap_action 'reserve_connection', args: { connection: Connection, access_token: :string }, return: { reservation: Reservation }
	def reserve_connection
		get_wallet_and_connection
		reservation = Reservation.new(wallet: @wallet, connection: @connection)
		if reservation.can_be_paid?
			ApplicationRecord.transaction do
				reservation.assign_confirmation_code
				@wallet.update!(balance: @wallet.balance - @connection.price)
			end
			render soap: { reservation: reservation.serialized }
		else
			raise SOAPError.new("Insufficient wallet balance")
		end
	end

private

	def connection_request_params
		params.require(:connection_request).permit(:start_station_name, :end_station_name, :departure).symbolize_keys
	end

	def get_wallet_and_connection
		@wallet = Wallet.find_by(access_token: params[:access_token])
		raise SOAPError.new("Wallet not found") unless @wallet
		@connection = Connection.new(connection_params)
		raise SOAPError.new("Connection not found") unless @connection
	end

	def connection_params
		params.require(:connection).permit(:departure, :arrival, :start_station_name, :end_station_name, :train_nr, :price).symbolize_keys
	end
end
