class ConnectionRequest < WashOut::Type
	attr_accessor :start_station_name, :end_station_name, :departure

	map start_station_name: :string, end_station_name: :string, departure: :datetime
	
	def initialize(start_station_name:, end_station_name:, departure:)
		@start_station_name = start_station_name
		@end_station_name = end_station_name
		@departure = departure
	end
end