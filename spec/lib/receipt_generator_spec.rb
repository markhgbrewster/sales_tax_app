# frozen_string_literal: true

require_relative '../../lib/receipt_generator'
require_relative '../../models/item'
require_relative '../../lib/tax_calculator'

RSpec.describe ReceiptGenerator do
  describe '.receipt' do
    subject { ReceiptGenerator.generate_for([]) }

    let(:expected) { "Sales Taxes: 0.00\nTotal: 0.00" }

    context 'when there are no items' do
      it 'returns zero sales taxes and zero total' do
        expect(subject).to eq(expected)
      end
    end

    context 'for Input 1' do
      let(:item1) do
        Item.new(
          quantity: 2,
          name: 'book',
          price: 12.49,
          tax_exempt: true,
          imported: false
        )
      end

      let(:item2) do
        Item.new(
          quantity: 1,
          name: 'music CD',
          price: 14.99,
          tax_exempt: false,
          imported: false
        )
      end

      let(:item3) do
        Item.new(
          quantity: 1,
          name: 'chocolate bar',
          price: 0.85,
          tax_exempt: true,
          imported: false
        )
      end

      let(:expected) do
        "2 book: 24.98\n" \
          "1 music CD: 16.49\n" \
          "1 chocolate bar: 0.85\n" \
          "Sales Taxes: 1.50\n" \
          'Total: 42.32'
      end

      subject { ReceiptGenerator.generate_for([item1, item2, item3]) }

      it 'calculates total and sales taxes correctly' do
        expect(subject).to eq(expected)
      end
    end

    context 'for Input 2' do
      let(:item1) do
        Item.new(
          quantity: 1,
          name: 'imported box of chocolates',
          price: 10.00,
          tax_exempt: true,
          imported: true
        )
      end

      let(:item2) do
        Item.new(
          quantity: 1,
          name: 'imported bottle of perfume',
          price: 47.50,
          tax_exempt: false,
          imported: true
        )
      end

      let(:expected) do
        "1 imported box of chocolates: 10.50\n" \
          "1 imported bottle of perfume: 54.65\n" \
          "Sales Taxes: 7.65\n" \
          'Total: 65.15'
      end

      subject { ReceiptGenerator.generate_for([item1, item2]) }

      it 'calculates total and sales taxes correctly' do
        expect(subject).to eq(expected)
      end
    end

    context 'for Input 3' do
      let(:item1) do
        Item.new(
          quantity: 1,
          name: 'imported bottle of perfume',
          price: 27.99,
          tax_exempt: false,
          imported: true
        )
      end

      let(:item2) do
        Item.new(
          quantity: 1,
          name: 'bottle of perfume',
          price: 18.99,
          tax_exempt: false,
          imported: false
        )
      end

      let(:item3) do
        Item.new(
          quantity: 1,
          name: 'packet of headache pills',
          price: 9.75,
          tax_exempt: true,
          imported: false
        )
      end

      let(:item4) do
        Item.new(
          quantity: 3,
          name: 'imported box of chocolates',
          price: 11.25,
          tax_exempt: true,
          imported: true
        )
      end

      let(:expected) do
        "1 imported bottle of perfume: 32.19\n" \
          "1 bottle of perfume: 20.89\n" \
          "1 packet of headache pills: 9.75\n" \
          "3 imported box of chocolates: 35.55\n" \
          "Sales Taxes: 7.90\n" \
          'Total: 98.38'
      end

      subject { ReceiptGenerator.generate_for([item1, item2, item3, item4]) }

      it 'calculates total and sales taxes correctly' do
        expect(subject).to eq(expected)
      end
    end
  end
end
