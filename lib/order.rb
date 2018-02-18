class Order
	attr_reader :item_list

	# item_list : the fruits customer want to buy
	def initialize(item_list)
		@item_list = item_list
	end
	
end
