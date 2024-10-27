# frozen_string_literal: true

require_relative './models/item'
require_relative './lib/tax_calculator'
require_relative './lib/item_builder'
require_relative './lib/receipt_generator'

# A command line interface that generates the receipt
# based on single string inputs eg "2 book at 12.49"
class SingleStringInput
  def start
    @items = []

    loop do
      add_item
      puts 'Do you want to add another item? (yes/no)'
      break unless gets.chomp.downcase == 'yes'
    end

    puts ReceiptGenerator.generate_for(@items)
  end

  private

  def add_item
    puts "Please enter an item as a full string (e.g., '2 book at 12.49'):"
    input = gets.chomp
    item = ItemBuilder.item(input)

    if item
      @items << item
    else
      puts "Invalid input format. Please use 'quantity product_type at price'."
    end
  end
end

SingleStringInput.new.start
