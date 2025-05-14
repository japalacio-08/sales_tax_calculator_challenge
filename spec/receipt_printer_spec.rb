require 'receipt_printer'
require 'basket'
require 'line_item'
require 'product'
require 'tax_calculator'

RSpec.describe ReceiptPrinter do
  let(:tax_calculator) { TaxCalculator.new }
  let(:basket) { Basket.new(tax_calculator:) }
  let(:printer) { described_class.new(basket) }

  describe '#print' do
    it 'prints a receipt with items, taxes, and total' do
      # Add items to basket
      book = Product.new(name: 'Book', price: 12.49, category: :book)
      music_cd = Product.new(name: 'Music CD', price: 14.99, category: :other)
      chocolate = Product.new(name: 'Chocolate Bar', price: 0.85, category: :food)

      basket.add(LineItem.new(book, 1))
      basket.add(LineItem.new(music_cd, 1))
      basket.add(LineItem.new(chocolate, 1))

      expected_output = [
        '1 Book: 12.49',
        '1 Music CD: 16.49',
        '1 Chocolate Bar: 0.85',
        'Sales Taxes: 1.50',
        'Total: 29.83'
      ].join("\n")

      expect(printer.print).to eq(expected_output)
    end

    it 'handles imported items correctly' do
      imported_chocolate = Product.new(
        name: 'Imported Chocolate',
        price: 10.00,
        category: :food,
        imported: true
      )

      basket.add(LineItem.new(imported_chocolate, 1))

      expected_output = [
        '1 Imported Chocolate: 10.50',
        'Sales Taxes: 0.50',
        'Total: 10.50'
      ].join("\n")

      expect(printer.print).to eq(expected_output)
    end

    it 'handles multiple quantities correctly' do
      book = Product.new(name: 'Book', price: 12.49, category: :book)
      basket.add(LineItem.new(book, 2))

      expected_output = [
        '2 Book: 24.98',
        'Sales Taxes: 0.00',
        'Total: 24.98'
      ].join("\n")

      expect(printer.print).to eq(expected_output)
    end

    it 'handles empty basket' do
      expected_output = [
        'Sales Taxes: 0.00',
        'Total: 0.00'
      ].join("\n")

      expect(printer.print).to eq(expected_output)
    end
  end
end
