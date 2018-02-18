class Helper
	require 'json'

	# Load from a local JSON file "fruits_list.json" (better load from a cached DB, but just keep it simple here)
	# This won't be tested.
	def self.load_fruit_list_from_json(url)
		fruit_list = {}

		data = JSON.parse(File.read(url))
		data.each do |f|
			pack_price = {}
			# JSON key is string, so do a conversion here
			f["pack_price"].each {|k,v| pack_price[k.to_i] = v }

			fruit = Fruit.new(f["name"],f["code"],pack_price)
			fruit_list[fruit.code] = fruit
		end

		return fruit_list
	end
end