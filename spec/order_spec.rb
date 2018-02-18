# spec/order.rb
require "order"

describe Order do

	subject(:order) { Order.new([ {code: "w01", qty: 10}, {code: "p01", qty: 14}, {code: "r01", qty: 13} ]) }

	it "returns the item list" do
		expect(order.item_list.size).to eq 3
		expect(order.item_list[0][:qty]).to eq 10
		expect(order.item_list[1][:qty]).to eq 14
		expect(order.item_list[2][:qty]).to eq 13
	end

end