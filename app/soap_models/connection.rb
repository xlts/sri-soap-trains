class Connection < WashOut::Type
	attr_accessor :id, :departure, :arrival, :start_station_name, :end_station_name, :train_nr, :price
  map id: :integer, departure: :datetime, arrival: :datetime, start_station_name: :string, end_station_name: :string, train_nr: :integer, price: :double
  

  def self.all
  	[Connection.new(
		id: 1,
		departure: Time.parse('2017-01-01 10:00'),
		arrival: Time.parse('2017-01-01 12:30'),
		start_station_name: 'Warszawa Centralna',
		end_station_name: 'Kraków Główny',
		train_nr: 11250,
		price: 10.21
	  ),
	  Connection.new(
		id: 2,
		departure: Time.parse('2017-01-02 11:00'),
		arrival: Time.parse('2017-01-01 15:30'),
		start_station_name: 'Warszawa Centralna',
		end_station_name: 'Wrocław Główny',
		train_nr: 16411,
		price: 15.60
	  ),
	  Connection.new(
		id: 3,
		departure: Time.parse('2017-01-01 11:00'),
		arrival: Time.parse('2017-01-01 14:25'),
		start_station_name: 'Kraków Główny',
		end_station_name: 'Katowice',
		train_nr: 66491,
		price: 64.41
	  ),
	  Connection.new(
		id: 4,
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
end