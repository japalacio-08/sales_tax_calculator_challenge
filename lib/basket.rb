class Basket
  attr_reader :items, :tax_calculator

  def initialize(tax_calculator: TaxCalculator.new)
    @items          = []
    @tax_calculator = tax_calculator
  end

  # Adds a line item to the basket
  #
  # @param line_item [LineItem] the line item to add
  def add(line_item)
    items << line_item
  end

  # Calculates the total sales taxes for all items in the basket
  #
  # @return [Float] the total sales taxes rounded to 2 decimal places
  def total_sales_taxes
    items.sum { |li| li.total_tax(tax_calculator) }.round(2)
  end

  # Calculates the total cost of all items in the basket including taxes
  #
  # @return [Float] the total cost rounded to 2 decimal places
  def total_cost
    items.sum { |li| li.total_price(tax_calculator) }.round(2)
  end
end
