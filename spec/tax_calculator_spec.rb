require 'tax_calculator'
require 'product'

RSpec.describe TaxCalculator do
  let(:calculator) { described_class.new }

  describe '#tax_for' do
    it 'applies basic tax rate for non-exempt products' do
      product = Product.new(
        name: 'Music CD',
        price: 14.99,
        category: :other
      )

      # Basic tax rate is 10%
      # 14.99 * 0.10 = 1.499
      # Rounded up to nearest 0.05 = 1.50
      expect(calculator.tax_for(product)).to eq(1.50)
    end

    it 'applies no tax for exempt products' do
      exempt_categories = Product::EXEMPT

      exempt_categories.each do |category|
        product = Product.new(
          name: 'Test Product',
          price: 10.00,
          category:
        )
        expect(calculator.tax_for(product)).to eq(0.00)
      end
    end

    it 'applies import tax for imported products' do
      product = Product.new(
        name: 'Imported Product',
        price: 10.00,
        category: :food,
        imported: true
      )

      # Import tax rate is 5%
      # 10.00 * 0.05 = 0.50
      expect(calculator.tax_for(product)).to eq(0.50)
    end

    it 'applies both basic and import tax for imported non-exempt products' do
      product = Product.new(
        name: 'Imported Music CD',
        price: 10.00,
        category: :other,
        imported: true
      )

      # Basic tax (10%) + Import tax (5%) = 15%
      # 10.00 * 0.15 = 1.50
      expect(calculator.tax_for(product)).to eq(1.50)
    end

    it 'rounds up to nearest 0.05' do
      product = Product.new(
        name: 'Test Product',
        price: 11.25,
        category: :other
      )

      # Basic tax rate is 10%
      # 11.25 * 0.10 = 1.125
      # Rounded up to nearest 0.05 = 1.15
      expect(calculator.tax_for(product)).to eq(1.15)
    end
  end
end
