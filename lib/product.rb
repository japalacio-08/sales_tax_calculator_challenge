require_relative 'validations'

class Product
  EXEMPT = %i[book food medical].freeze
  attr_reader :name, :price, :category, :imported

  include Validations

  validate :name, type: String, presence: true
  validate :price, type: Numeric, presence: true, positive: true
  validate :category, type: Symbol, presence: true, includes: EXEMPT + [:other]
  validate :imported, type: [TrueClass, FalseClass], presence: true

  def initialize(name:, price:, category:, imported: false)
    @name     = name
    @price    = price
    @category = category
    @imported = imported

    validate!
    freeze
  end

  # Checks if the product's category is applicable for basic sales tax
  #
  # @return [Boolean] true if the category is not in the EXEMPT list, false otherwise
  def basic_tax_applicable?
    !EXEMPT.include?(category)
  end
end
