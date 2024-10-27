# frozen_string_literal: true

# Calculates the tax for a given instance of Item
class TaxCalculator
  BASIC_TAX_RATE = 0.10
  IMPORT_DUTY = 0.05

  private_class_method :new

  class << self
    def calculate_tax(item)
      tax_rate = 0
      tax_rate += BASIC_TAX_RATE unless item.tax_exempt?
      tax_rate += IMPORT_DUTY if item.imported?
      round_tax(item.price * tax_rate)
    end

    # Rounds to the nearest 0.05
    def round_tax(tax)
      (tax * 20).ceil / 20.0
    end
  end
end
