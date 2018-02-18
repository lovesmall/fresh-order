# fresh-order
Generate invoice for fresh order

## Design

- `furit.rb`: the class for a fruit. It contains a name, a code and the price table for different pack size.

- `order.rb`: a simple class represent a customer order. It contains multiple fruits and quantity for each.

- `store.rb`: the place where:
  1. Find the best combination for each fruit in the order. You can find the detailed algo in function comments
  2. Print a nice invoice.

- `helper.rb`: just load the fruit pack price table from local JSON file "data/fruit_list.json"

## Run

The default order is "10 Watermelons, 14 Pineapples, 13 Rockmelons", you can get the result by run the "freshorder.rb" file.
You can also try any other file by changing the "order" in this file.

## Test

Use `rspec` to run all the test after bundle. For `store.rb`, "print nice invoice" is not tested as format is not relevant.
