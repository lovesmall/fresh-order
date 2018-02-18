class Store
	attr_reader :fruit_table

	def initialize(fruit_table)
		@fruit_table = fruit_table
	end

	def process_order(order)
		pack_comb_list = calculate_pack_comb_list(order)
		invoice = generate_invoice_order(pack_comb_list)

		puts invoice
		return invoice
	end

	# Find the best combination for each furit in an order
	def calculate_pack_comb_list(order)
		pack_comb_list = []
		order.item_list.each do |item|
			table = @fruit_table[item[:code]].pack_price_table
			target = item[:qty]

			all_comb_list = calculate_all_comb(table.keys, target)
			best_comb = calculate_best_comb(table, all_comb_list) || {}

			pack_comb_list << [item[:code], best_comb]
		end
		return pack_comb_list
	end

	# Generate invoice for all combinations
	def generate_invoice_order(pack_comb_list)
		print_text = ""
		total_price = 0
		total_qty = 0
		pack_comb_list.each do |pack_comb|
			pack_invoice = generate_invoice_item(pack_comb)

			total_price = total_price + pack_invoice[:total_price]
			total_qty = total_qty + pack_invoice[:total_qty]
			print_text = print_text + pack_invoice[:print_text] + "\n"
		end

		print_text = print_text + \
		"-------------------------\nTOTAL              $#{total_price.round(2)}"

		return print_text
	end



	private

	# Recursively find all combinations that equal the target
	# Because sometimes smaller pack size could be cheaper, so need to find all possible combinations

	# input : [8,5,2], 14
	# output: [{8=>1, 2=>3}, {5=>2, 2=>2}, {2=>7}]
	def calculate_all_comb(comb_table, target, comb = {}, all_comb_list = [])
		i = 0
		while i < comb_table.size do

			pack_size = comb_table[i]
			if target >= pack_size

				# Make a clone is important here
				# We want to keep the same comb/target/comb_table for next loop
				new_comb = comb.clone()
				new_comb[pack_size] ||= 0
				new_comb[pack_size] += 1

				if target == pack_size # Found a valid comb, push it to all_comb_list
					all_comb_list.push(new_comb)

				else # Continue search smaller target/comb_table
					new_target = target - pack_size
					new_comb_table = comb_table[i..comb_table.size]

					# The SAME "all_comb_list" is used as we need it to be MODIFIED if found a valid comb
					calculate_all_comb(new_comb_table, new_target, new_comb, all_comb_list)				
				end

			end # end if
			i = i + 1

		end # end while

		return all_comb_list
	end

	# Find the lowest price combination based on the fruit price pack table
	def calculate_best_comb(pack_price_table, comb_list)
		return comb_list.first if comb_list.size == 1

		best_comb = comb_list.first
		best_price = nil

		comb_list.each do |comb|
			total = 0

			comb.each do |pack, qty|
				unit_price = pack_price_table[pack]
				total += unit_price * qty
			end
			
			best_price ||= total
			if total < best_price
				best_price = total 
				best_comb = comb
			end
		end

		return best_comb
	end


	# Generate invoice for one fruit item
	def generate_invoice_item(pack_comb)
		total_qty = 0
		total_price = 0
		print_text = ""
		fruit = @fruit_table[pack_comb[0]]

		pack_comb[1].each do |pack, qty|
			next if qty == 0

			unit_price = fruit.pack_price(pack)
			print_text = print_text + "\n" + " - #{qty} x #{pack} @ $#{unit_price.round(2)}".rjust(25," ")
			
			total_price = total_price + qty * unit_price
			total_qty = total_qty + qty * pack
		end

		print_text = total_qty == 0 ? "" : "#{total_qty} #{fruit.name} $#{'%.2f' % total_price.round(2)}".rjust(25," ") + print_text + "\n"
		print_text.rjust(25," ")
		
		return { total_qty:total_qty, total_price:total_price.round(2), print_text: print_text }
	end



end


