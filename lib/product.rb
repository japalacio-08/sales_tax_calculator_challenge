class Product
  EXEMPT = %i[book food medical].freeze
  attr_reader :name, :price, :category, :imported

  def initialize(name:, price:, category:, imported: false)
    @name     = name
    @price    = price
    @category = category
    @imported = imported
    freeze
  end

  # Checks if the product's category is applicable for basic sales tax
  #
  # @return [Boolean] true if the category is not in the EXEMPT list, false otherwise
  def basic_tax_applicable?
    !EXEMPT.include?(category)
  end
end
