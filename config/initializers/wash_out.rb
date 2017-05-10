module WashOut
  class Type
  	def serialized
  		self.class.wash_out_param_map.keys.map { |key| [key, send(key)] }.to_h
  	end
  end
end