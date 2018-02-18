require "./lib/order.rb"
require "./lib/helper.rb"
require "./lib/fruit.rb"
require "./lib/store.rb"

store = Store.new(Helper.load_fruit_list_from_json("data/fruit_list.json"))
order = Order.new([
	{code: "w01", qty: 10}, 
	{code: "p01", qty: 14}, 
	{code: "r01", qty: 13}
	])

puts "Order: \n10 Watermelons, 14 Pineapples, 13 Rockmelons \n\n"
puts "Invoice: \n"

store.process_order(order)