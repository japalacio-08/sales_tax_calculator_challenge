require 'line_item'
require 'product'
require 'tax_calculator'

RSpec.describe LineItem do
  let(:tax_calculator) { TaxCalculator.new }
  let(:product) { Product.new(name: 'Test Product', price: 10.00, category: :other) }
  let(:line_item) { described_class.new(product, 2) }

  describe '#initialize' do
    it 'initializes with product and quantity' do
      expect(line_item.product).to eq(product)
      expect(line_item.quantity).to eq(2)
    end

    it 'is immutable' do
      expect(line_item).to be_frozen
    end
  end

  describe '#total_price' do
    it 'calculates total price including tax for multiple items' do
      # Product price: 10.00
      # Tax rate: 10% (0.10)
      # Tax per item: 10.00 * 0.10 = 1.00
      # Total per item: 10.00 + 1.00 = 11.00
      # Total for 2 items: 11.00 * 2 = 22.00
      expect(line_item.total_price(tax_calculator)).to eq(22.00)
    end

    it 'handles exempt products correctly' do
      exempt_product = Product.new(name: 'Book', price: 10.00, category: :book)
      exempt_line_item = described_class.new(exempt_product, 2)

      # No tax for exempt products
      expect(exempt_line_item.total_price(tax_calculator)).to eq(20.00)
    end

    it 'handles imported products correctly' do
      imported_product = Product.new(name: 'Imported Item', price: 10.00, category: :other, imported: true)
      imported_line_item = described_class.new(imported_product, 2)

      # Basic tax (10%) + Import tax (5%) = 15%
      # Tax per item: 10.00 * 0.15 = 1.50
      # Total per item: 10.00 + 1.50 = 11.50
      # Total for 2 items: 11.50 * 2 = 23.00
      expect(imported_line_item.total_price(tax_calculator)).to eq(23.00)
    end
  end

  describe '#total_tax' do
    it 'calculates total tax for multiple items' do
      # Tax per item: 10.00 * 0.10 = 1.00
      # Total tax for 2 items: 1.00 * 2 = 2.00
      expect(line_item.total_tax(tax_calculator)).to eq(2.00)
    end

    it 'returns zero tax for exempt products' do
      exempt_product = Product.new(name: 'Book', price: 10.00, category: :book)
      exempt_line_item = described_class.new(exempt_product, 2)
      expect(exempt_line_item.total_tax(tax_calculator)).to eq(0.00)
    end

    it 'calculates combined tax for imported products' do
      imported_product = Product.new(name: 'Imported Item', price: 10.00, category: :other, imported: true)
      imported_line_item = described_class.new(imported_product, 2)

      # Basic tax (10%) + Import tax (5%) = 15%
      # Tax per item: 10.00 * 0.15 = 1.50
      # Total tax for 2 items: 1.50 * 2 = 3.00
      expect(imported_line_item.total_tax(tax_calculator)).to eq(3.00)
    end
  end
end
