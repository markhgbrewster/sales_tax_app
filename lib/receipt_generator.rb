# frozen_string_literal: true

require_relative '../models/item'
require_relative 'tax_calculator'

# Generates A receipt text from an Array of Item instances
class ReceiptGenerator
  private_class_method :new

  class << self
    def generate_for(items)
      @total_sales_taxes = 0
      @total_price = 0

      receipt_lines = item_lines(items)

      receipt_lines << "Sales Taxes: #{format('%.2f', @total_sales_taxes)}"
      receipt_lines << "Total: #{format('%.2f', @total_price)}"
      receipt_lines.join("\n")
    end

    private

    def item_lines(items)
      items.compact.map do |item|
        tax = TaxCalculator.calculate_tax(item)
        total_price_with_tax = (item.price + tax) * item.quantity
        @total_sales_taxes += tax * item.quantity
        @total_price += total_price_with_tax

        "#{item.quantity} #{item.name}: #{format('%.2f', total_price_with_tax)}"
      end
    end
  end
end
