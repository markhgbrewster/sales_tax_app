# frozen_string_literal: true

require_relative './models/item'
require_relative './lib/tax_calculator'
require_relative './lib/receipt_generator'

# A command line interface that generates the receipt
# based on individual attributes for each item
class ManualInput
  def start
    @items = []
    loop do
      ask_for_item
      continue = ask_yes_no('Do you want to add another item? (yes/no)')
      break unless continue
    end

    puts ReceiptGenerator.generate_for(@items)
  end

  private

  def ask_for_item
    name = ask_for_name
    quantity = ask_for_quantity
    price = ask_for_price
    imported = ask_yes_no('Is the item imported? (yes/no):')
    tax_exempt = ask_yes_no('Is the item tax exempt? (yes/no):')

    # Create the item and add it to the items array
    @items << Item.new(quantity:, name:, price:, tax_exempt:, imported:)
  end

  def ask_for_name
    loop do
      puts 'Please enter the item name:'
      name = gets.chomp
      return name unless name.strip.empty?

      puts 'Invalid input. Item name cannot be blank.'
    end
  end

  def ask_for_quantity
    loop do
      puts 'Please enter the quantity (must be an integer):'
      input = gets.chomp
      return input.to_i if valid_integer?(input)

      puts 'Invalid input. Please enter a valid integer for quantity.'
    end
  end

  def ask_for_price
    loop do
      puts 'Please enter the price (e.g., 12.49):'
      input = gets.chomp
      return input.to_f if valid_float?(input)

      puts 'Invalid input. Please enter a valid float number for price.'
    end
  end

  def ask_yes_no(prompt)
    loop do
      puts prompt
      input = gets.chomp.downcase
      return true if input == 'yes'
      return false if input == 'no'

      puts 'Invalid input. Please answer "yes" or "no".'
    end
  end

  def valid_integer?(input)
    Integer(input)
  rescue ArgumentError
    false
  end

  def valid_float?(input)
    Float(input)
  rescue ArgumentError
    false
  end
end

ManualInput.new.start
