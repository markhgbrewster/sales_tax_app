# frozen_string_literal: true

require_relative '../lib/item_builder'
require_relative '../models/item'
require_relative '../lib/receipt_generator'

# This is just testing that the the whole this works together
# with single sting inputs
RSpec.describe 'Single string inputs' do
  describe 'for Input 1' do
    let(:inputs) do
      [
        '2 book at 12.49',
        '1 music CD at 14.99',
        '1 chocolate bar at 0.85'
      ]
    end

    let(:expected) do
      "2 book: 24.98\n" \
        "1 music CD: 16.49\n" \
        "1 chocolate bar: 0.85\n" \
        "Sales Taxes: 1.50\n" \
        'Total: 42.32'
    end

    let(:items) { [] }

    before do
      inputs.each do |input|
        items << ItemBuilder.item(input)
      end
    end

    it 'returns the correct text' do
      expect(ReceiptGenerator.generate_for(items)).to eq(expected)
    end
  end

  describe 'for Input 2' do
    let(:inputs) do
      [
        '1 imported box of chocolates at 10.00',
        '1 imported bottle of perfume at 47.50'
      ]
    end

    let(:expected) do
      "1 imported box of chocolates: 10.50\n" \
        "1 imported bottle of perfume: 54.65\n" \
        "Sales Taxes: 7.65\n" \
        'Total: 65.15'
    end

    let(:items) { [] }

    before do
      inputs.each do |input|
        items << ItemBuilder.item(input)
      end
    end

    it 'returns the correct text' do
      expect(ReceiptGenerator.generate_for(items)).to eq(expected)
    end
  end

  describe 'for Input 3' do
    let(:inputs) do
      [
        '1 imported bottle of perfume at 27.99',
        '1 bottle of perfume at 18.99',
        '1 packet of headache pills at 9.75',
        '3 imported boxes of chocolates at 11.25'
      ]
    end

    let(:expected) do
      "1 imported bottle of perfume: 32.19\n" \
        "1 bottle of perfume: 20.89\n" \
        "1 packet of headache pills: 9.75\n" \
        "3 imported boxes of chocolates: 35.55\n" \
        "Sales Taxes: 7.90\n" \
        'Total: 98.38'
    end

    let(:items) { [] }

    before do
      inputs.each do |input|
        items << ItemBuilder.item(input)
      end
    end

    it 'returns the correct text' do
      expect(ReceiptGenerator.generate_for(items)).to eq(expected)
    end
  end
end
