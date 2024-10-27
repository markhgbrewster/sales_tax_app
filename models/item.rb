# frozen_string_literal: true

# An object for storing the attributes for a product
class Item
  attr_reader :quantity, :name, :price

  def initialize(quantity:, name:, price:, tax_exempt:, imported:)
    @quantity = quantity
    @name = name
    @price = price
    @imported = imported
    @tax_exempt = tax_exempt
  end

  # The below 2 predicate methods could have been done
  # with !!attribute or an alias to the attribute.
  # However, I wanted to specifically check for it being true
  # Not just truthy as to avoid the tax being added or removed
  # If the attribute was set erroneously
  def imported?
    imported == true
  end

  def tax_exempt?
    tax_exempt == true
  end

  private

  attr_reader :tax_exempt, :imported
end
