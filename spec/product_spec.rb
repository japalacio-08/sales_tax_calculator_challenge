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

  describe 'input validation' do
    describe 'name validation' do
      it 'raises error for nil name' do
        expect do
          described_class.new(name: nil, price: 10.00, category: :other)
        end.to raise_error(ArgumentError, 'Value cannot be nil')
      end

      it 'raises error for empty name' do
        expect do
          described_class.new(name: '', price: 10.00, category: :other)
        end.to raise_error(ArgumentError, 'Value cannot be empty')
      end

      it 'raises error for non-string name' do
        expect do
          described_class.new(name: 123, price: 10.00, category: :other)
        end.to raise_error(ArgumentError, 'Integer is not a String')
      end
    end

    describe 'price validation' do
      it 'raises error for nil price' do
        expect do
          described_class.new(name: 'Test', price: nil, category: :other)
        end.to raise_error(ArgumentError, 'Value cannot be nil')
      end

      it 'raises error for negative price' do
        expect do
          described_class.new(name: 'Test', price: -10.00, category: :other)
        end.to raise_error(ArgumentError, 'Value must be positive')
      end

      it 'raises error for zero price' do
        expect do
          described_class.new(name: 'Test', price: 0, category: :other)
        end.to raise_error(ArgumentError, 'Value must be positive')
      end

      it 'raises error for non-numeric price' do
        expect do
          described_class.new(name: 'Test', price: '10.00', category: :other)
        end.to raise_error(ArgumentError, 'String is not a Numeric')
      end
    end

    describe 'category validation' do
      it 'raises error for nil category' do
        expect do
          described_class.new(name: 'Test', price: 10.00, category: nil)
        end.to raise_error(ArgumentError, 'Value cannot be nil')
      end

      it 'raises error for non-symbol category' do
        expect do
          described_class.new(name: 'Test', price: 10.00, category: 'book')
        end.to raise_error(ArgumentError, 'String is not a Symbol')
      end

      it 'raises error for invalid category' do
        expect do
          described_class.new(name: 'Test', price: 10.00, category: :invalid)
        end.to raise_error(ArgumentError, 'Value must be included in [:book, :food, :medical, :other]')
      end
    end

    describe 'imported validation' do
      it 'raises error for nil imported flag' do
        expect do
          described_class.new(name: 'Test', price: 10.00, category: :other, imported: nil)
        end.to raise_error(ArgumentError, 'Value cannot be nil')
      end

      it 'raises error for non-boolean imported flag' do
        expect do
          described_class.new(name: 'Test', price: 10.00, category: :other, imported: 'true')
        end.to raise_error(ArgumentError, 'String is not a Boolean')
      end
    end
  end
end
