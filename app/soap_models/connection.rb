class Connection < WashOut::Type
	attr_accessor :departure, :arrival, :start_station_name, :end_station_name, :train_nr, :price

  	map departure: :datetime, arrival: :datetime, start_station_name: :string, end_station_name: :string, train_nr: :integer, price: :double
  
  def initialize(departure:, arrival:, start_station_name:, end_station_name:, train_nr:, price:)
  	@departure = departure
  	@arrival = arrival
  	@start_station_name = start_station_name
  	@end_station_name = end_station_name
  	@train_nr = train_nr
  	@price = price
  end

  def self.all
  	[Connection.new(
		departure: Time.parse('2017-01-01 10:00'),
		arrival: Time.parse('2017-01-01 12:30'),
		start_station_name: 'Warszawa Centralna',
		end_station_name: 'Kraków Główny',
		train_nr: 11250,
		price: 10.21
	  ),
	  Connection.new(
		departure: Time.parse('2017-01-02 11:00'),
		arrival: Time.parse('2017-01-01 15:30'),
		start_station_name: 'Warszawa Centralna',
		end_station_name: 'Wrocław Główny',
		train_nr: 16411,
		price: 15.60
	  ),
	  Connection.new(
		departure: Time.parse('2017-01-01 11:00'),
		arrival: Time.parse('2017-01-01 14:25'),
		start_station_name: 'Kraków Główny',
		end_station_name: 'Katowice',
		train_nr: 66491,
		price: 64.41
	  ),
	  Connection.new(
		departure: Time.parse('2017-01-02 18:00'),
		arrival: Time.parse('2017-01-01 20:25'),
		start_station_name: 'Wrocław Główny',
		end_station_name: 'Szczecin Dąbie',
		train_nr: 51221,
		price: 1.24
	  )
	]
  end

  def self.find_by_connection_request(request)
  	all.select do |connection|
  		connection.start_station_name == request.start_station_name &&
  			connection.end_station_name == request.end_station_name &&
  			connection.departure >= request.departure
  	end
  end

  def self.find_by_connection_params(params)
  	all.find do |connection|
  		connection.start_station_name == params.start_station_name &&
  			connection.end_station_name == params.end_station_name &&
  			connection.departure == params.departure &&
  			connection.arrival == params.arrival &&
  			connection.train_nr == params.train_nr &&
  			connection.price == params.price 
  	end
  end
end