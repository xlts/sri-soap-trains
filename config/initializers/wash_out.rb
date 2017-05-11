module WashOut
  class Type
  	def serialized
  		self.class.wash_out_param_map.map do |key, value|
  			if value.is_a?(Class)
  				[key, send(key).serialized]
  			else
  				[key, send(key)]
  			end
  		end.to_h
  	end
  end
end