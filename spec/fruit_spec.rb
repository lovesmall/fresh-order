# spec/fruit.rb
require "fruit"

describe Fruit do

	subject(:fruit) { Fruit.new("Watermelons", "W01", {3=>6.99, 5=>8.99})  }

	it "returns the name" do
		expect(fruit.name).to eq "Watermelons"
	end

	it "returns the code" do
		expect(fruit.code).to eq "W01"
	end

	it "returns the sorted pack price list" do
		expect(fruit.pack_price_table.keys).to eq [5,3]
		expect(fruit.pack_price_table[5]).to eq 8.99
		expect(fruit.pack_price_table[3]).to eq 6.99
	end


	describe "#pack_price" do

		it "returns the price for valid packs" do
			expect(fruit.pack_price(3)).to eq 6.99
		end

		it "returns 0 for invalid packs" do
			expect(fruit.pack_price(2)).to eq 0
		end

	end

end