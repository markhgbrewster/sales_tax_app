# frozen_string_literal: true

require_relative '../models/item'

# Builds an item from a single string input
class ItemBuilder
  # This is not at great way to tell if the item is a book,food or medicine
  # but given the test data I don't think there is a better way
  # If I am to use a single string input
  TAX_EXEMPT_KEYWORDS = %w[book chocolate pill].freeze

  private_class_method :new

  class << self
    def item(input)
      return unless input =~ /(\d+) (.+) at (\d+\.\d{2})/

      quantity = ::Regexp.last_match(1).to_i
      name = ::Regexp.last_match(2)
      price = ::Regexp.last_match(3).to_f

      tax_exempt = TAX_EXEMPT_KEYWORDS.any? do |word|
        name.downcase.include?(word)
      end

      imported = name.downcase.include?('imported')

      Item.new(quantity:, name:, price:, tax_exempt:, imported:)
    end
  end
end
