require 'product'

RSpec.describe Product do
  describe '#initialize' do
    it 'initializes with required attributes' do
      product = described_class.new(
        name: 'Test Product',
        price: 10.00,
        category: :other
      )

      expect(product.name).to eq('Test Product')
      expect(product.price).to eq(10.00)
      expect(product.category).to eq(:other)
      expect(product.imported).to be false
    end

    it 'accepts imported flag' do
      product = described_class.new(
        name: 'Imported Product',
        price: 10.00,
        category: :other,
        imported: true
      )

      expect(product.imported).to be true
    end

    it 'is immutable' do
      product = described_class.new(
        name: 'Test Product',
        price: 10.00,
        category: :other
      )

      expect(product).to be_frozen
    end
  end

  describe '#basic_tax_applicable?' do
    it 'returns false for exempt categories' do
      exempt_categories = described_class::EXEMPT

      exempt_categories.each do |category|
        product = described_class.new(
          name: 'Test Product',
          price: 10.00,
          category:
        )
        expect(product.basic_tax_applicable?).to be false
      end
    end

    it 'returns true for non-exempt categories' do
      product = described_class.new(
        name: 'Test Product',
        price: 10.00,
        category: :other
      )

      expect(product.basic_tax_applicable?).to be true
    end
  end
end
