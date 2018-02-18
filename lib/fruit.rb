class Fruit
	# Simple class for one type of fruit, with its code and its various packs prices.

	attr_reader :name, :code, :pack_price_table

	# pack_price_table : a hash table that store various packs prices.
	def initialize(name, code, pack_price_table)
		@name = name
		@code = code
		@pack_price_table = pack_price_table.sort.reverse.to_h
	end

	# get price for one pack size
	def pack_price(pack)
		@pack_price_table[pack] || 0
	end
end