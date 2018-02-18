# spec/store.rb
require "store"
require "helper"

describe Store do

	subject(:store) { Store.new(Helper.load_fruit_list_from_json("data/fruit_list.json") )  }

	let(:valid_order_1) { Order.new([ {code: "w01", qty: 10}, {code: "p01", qty: 14}, {code: "r01", qty: 13} ]) }
	let(:valid_order_2) { Order.new([ {code: "w01", qty: 8}, {code: "p01", qty: 21}, {code: "r01", qty: 20} ]) }

	let(:partial_valid_order_1) { Order.new([ {code: "w01", qty: 1}, {code: "p01", qty: 15} ]) }
	let(:partial_valid_order_2) { Order.new([ {code: "w01", qty: 15}, {code: "p01", qty: 5}, {code: "r01", qty: 2} ]) }

	let(:invalid_order_1) { Order.new([ {code: "w01", qty: 1}]) }
	let(:invalid_order_2) { Order.new([ {code: "w01", qty: 2}, {code: "p01", qty: 3}]) }

	it "returns the fruit list" do
		expect(store.fruit_table.keys).to eq ["w01","p01","r01"]
	end

	describe "#calculate_pack_comb_list" do
		it "returns ['w01', {5=>2}], ['p01', {5=>2, 2=>2}], ['r01', {5=>2, 3=>1}] for valid order 1" do
			pack_comb_list = store.calculate_pack_comb_list(valid_order_1)
			expect(pack_comb_list).to eq(
				[["w01",{5=>2}],["p01",{5=>2,2=>2}],["r01",{5=>2,3=>1}]]
			)
		end

		it "returns ['w01', {5=>2}], ['p01', {8=>2, 5=>1}], ['r01', {9=>2}] for valid order 2" do
			pack_comb_list = store.calculate_pack_comb_list(valid_order_2)
			expect(pack_comb_list).to eq(
				[["w01",{5=>1,3=>1}],["p01",{8=>2,5=>1}],["r01",{9=>1, 5=>1, 3=>2}]]
			)
		end

		it "returns ['w01', {}],['p01', {5=>3}] for partial valid order 1" do
			pack_comb_list = store.calculate_pack_comb_list(partial_valid_order_1)
			expect(pack_comb_list).to eq(
				[["w01", {}],["p01", {5=>3}]]
			)
		end

		it "returns ['w01', {5=>3}],['p01', {5=>1}],['r01', {}] for partial valid order 2" do
			pack_comb_list = store.calculate_pack_comb_list(partial_valid_order_2)
			expect(pack_comb_list).to eq(
				[["w01", {5=>3}],["p01", {5=>1}],["r01", {}]]
			)
		end

		it "returns ['w01', {}] for invalid order 1" do
			pack_comb_list = store.calculate_pack_comb_list(invalid_order_1)
			expect(pack_comb_list).to eq(
				[["w01", {}]]
			)
		end

		it "returns [['w01', {}], ['p01', {}]] for valid order 2" do
			pack_comb_list = store.calculate_pack_comb_list(invalid_order_2)
			expect(pack_comb_list).to eq(
				[["w01", {}], ["p01", {}]]
			)
		end
	end


	describe "#generate_invoice_order" do
		it "is not tested as format is not important in this test" do
		end
	end

	describe "#process_order" do
		it "is not tested as it's just a wrapper in this test" do
			# store.process_order(valid_order_1)
		end
	end
	


end