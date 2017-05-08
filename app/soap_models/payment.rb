class Payment < WashOut::Type
  map {
    id: :integer,
    connection_id: :integer,
    amount: :double
  }
end