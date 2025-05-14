#!/usr/bin/env ruby
require_relative '../lib/product'
require_relative '../lib/line_item'
require_relative '../lib/tax_calculator'
require_relative '../lib/basket'
require_relative '../lib/receipt_printer'

def parse_line(line)
  # e.g. "1 imported box of chocolates at 10.00"
  qty, rest = line.split(' ', 2)
  name, price = rest.split(' at ')
  imported = name.include?('imported')
  # naive category detection:
  cat = if name.match?(/book/)
          :book
        elsif name.match?(/chocolate|chocolates/)
          :food
        elsif name.match?(/pills/)
          :medical
        else
          :other
        end
  [qty.to_i, name, price.to_f, cat, imported]
end

input = ARGF.read.lines.map(&:strip).reject(&:empty?)
basket = Basket.new

input.each do |line|
  qty, name, price, cat, imp = parse_line(line)
  prod = Product.new(name:, price:, category: cat, imported: imp)
  basket.add(LineItem.new(prod, qty))
end

puts ReceiptPrinter.new(basket).print
