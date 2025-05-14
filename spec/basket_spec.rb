require 'basket'
require 'line_item'
require 'product'
require 'tax_calculator'

RSpec.describe Basket do
  let(:tax_calculator) { TaxCalculator.new }
  let(:basket) { described_class.new(tax_calculator:) }

  let(:book) { Product.new(name: 'Book', price: 12.49, category: :book) }
  let(:music_cd) { Product.new(name: 'Music CD', price: 14.99, category: :other) }
  let(:imported_chocolate) { Product.new(name: 'Imported Chocolate', price: 10.00, category: :food, imported: true) }

  describe '#initialize' do
    it 'initializes with empty items array' do
      expect(basket.items).to be_empty
    end

    it 'accepts a custom tax calculator' do
      custom_calculator = TaxCalculator.new
      basket = described_class.new(tax_calculator: custom_calculator)
      expect(basket.tax_calculator).to eq(custom_calculator)
    end
  end

  describe '#add' do
    it 'adds a line item to the basket' do
      line_item = LineItem.new(book, 1)
      basket.add(line_item)
      expect(basket.items).to include(line_item)
    end
  end

  describe '#total_sales_taxes' do
    it 'calculates total sales taxes for all items' do
      basket.add(LineItem.new(book, 1))           # No tax
      basket.add(LineItem.new(music_cd, 1))       # 10% tax
      basket.add(LineItem.new(imported_chocolate, 1)) # 5% import tax

      # Book: no tax
      # Music CD: 14.99 * 0.10 = 1.50
      # Imported Chocolate: 10.00 * 0.05 = 0.50
      expect(basket.total_sales_taxes).to eq(2.00)
    end
  end

  describe '#total_cost' do
    it 'calculates total cost including taxes for all items' do
      basket.add(LineItem.new(book, 1))           # 12.49
      basket.add(LineItem.new(music_cd, 1))       # 14.99 + 1.50 tax
      basket.add(LineItem.new(imported_chocolate, 1)) # 10.00 + 0.50 tax

      # Book: 12.49
      # Music CD: 14.99 + 1.50 = 16.49
      # Imported Chocolate: 10.00 + 0.50 = 10.50
      expect(basket.total_cost).to eq(39.48)
    end
  end
end
