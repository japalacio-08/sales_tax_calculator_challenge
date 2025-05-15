require_relative 'validations'
require_relative 'basket'

class ReceiptPrinter
  include Validations

  attr_reader :basket

  validate :basket, type: Basket, presence: true

  def initialize(basket)
    @basket = basket

    validate!
  end

  # Prints a formatted receipt for the basket
  #
  # @return [String] the formatted receipt
  def print
    lines = @basket.items.map do |li|
      price = format('%.2f', li.total_price(@basket.tax_calculator))
      "#{li.quantity} #{li.product.name}: #{price}"
    end
    lines << "Sales Taxes: #{format('%.2f', @basket.total_sales_taxes)}"
    lines << "Total: #{format('%.2f', @basket.total_cost)}"
    lines.join("\n")
  end
end
