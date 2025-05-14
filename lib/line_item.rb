require_relative 'tax_calculator'

class LineItem
  attr_reader :product, :quantity

  def initialize(product, quantity)
    @product  = product
    @quantity = quantity
    freeze
  end

  # Calculates the total price for the line item including tax
  #
  # @param tax_calculator [TaxCalculator] the tax calculator to use
  # @return [Float] the total price for the line item
  def total_price(tax_calculator)
    taxed = tax_calculator.tax_for(product) + product.price
    (taxed * quantity).round(2)
  end

  # Calculates the total tax for the line item
  #
  # @param tax_calculator [TaxCalculator] the tax calculator to use
  # @return [Float] the total tax for the line item
  def total_tax(tax_calculator)
    tax_for_one = tax_calculator.tax_for(product)
    (tax_for_one * quantity).round(2)
  end
end
