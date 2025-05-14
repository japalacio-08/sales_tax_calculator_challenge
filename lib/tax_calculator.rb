# Calculates sales tax for products based on their category and import status
#
# Basic sales tax is 10% on all goods, except books, food, and medical products
# Import duty is an additional 5% on all imported goods with no exemptions
# All tax rates are rounded up to the nearest 0.05
class TaxCalculator
  BASIC_RATE  = 0.10
  IMPORT_RATE = 0.05

  # Calculates the total tax amount for a given product
  #
  # Basic sales tax is 10% on all goods, except books, food, and medical products
  # Import duty is an additional 5% on all imported goods with no exemptions
  # All tax rates are rounded up to the nearest 0.05
  #
  # @param product [Product] the product to calculate tax for
  # @return [Float] the total tax amount rounded up to nearest 0.05
  def tax_for(product)
    rate = 0
    rate += BASIC_RATE  if product.basic_tax_applicable?
    rate += IMPORT_RATE if product.imported
    raw  = product.price * rate
    round_up_005(raw)
  end

  private

  # Rounds a tax amount up to the nearest 0.05
  #
  # @param amount [Float] the raw tax amount to round
  # @return [Float] the tax amount rounded up to nearest 0.05
  def round_up_005(amount)
    # Round up to the nearest 0.05, handling floating-point precision
    ((amount * 100).round / 100.0 * 20).ceil / 20.0
  end
end
