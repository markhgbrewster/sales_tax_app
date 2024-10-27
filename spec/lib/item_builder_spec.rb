# frozen_string_literal: true

require_relative '../../lib/item_builder'
require_relative '../../models/item'

RSpec.describe ItemBuilder do
  describe '.item' do
    context 'when the input is "2 book at 12.49"' do
      let(:input) { '2 book at 12.49' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 2,
          name: 'book',
          price: 12.49,
          tax_exempt?: true,
          imported?: false
        )
      end
    end

    context 'when the input is "1 music CD at 14.99"' do
      let(:input) { '1 music CD at 14.99' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 1,
          name: 'music CD',
          price: 14.99,
          tax_exempt?: false,
          imported?: false
        )
      end
    end

    context 'when the input is "1 chocolate bar at 0.85"' do
      let(:input) { '1 chocolate bar at 0.85' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 1,
          name: 'chocolate bar',
          price: 0.85,
          tax_exempt?: true,
          imported?: false
        )
      end
    end

    context 'when the input is "1 imported box of chocolates at 10.00"' do
      let(:input) { '1 imported box of chocolates at 10.00' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 1,
          name: 'imported box of chocolates',
          price: 10.00,
          tax_exempt?: true,
          imported?: true
        )
      end
    end

    context 'when the input is "1 imported bottle of perfume at 47.50"' do
      let(:input) { '1 imported bottle of perfume at 47.50' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 1,
          name: 'imported bottle of perfume',
          price: 47.50,
          tax_exempt?: false,
          imported?: true
        )
      end
    end

    context 'when the input is "1 imported bottle of perfume at 27.99"' do
      let(:input) { '1 imported bottle of perfume at 27.99' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 1,
          name: 'imported bottle of perfume',
          price: 27.99,
          tax_exempt?: false,
          imported?: true
        )
      end
    end

    context 'when the input is "1 bottle of perfume at 18.99"' do
      let(:input) { '1 bottle of perfume at 18.99' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 1,
          name: 'bottle of perfume',
          price: 18.99,
          tax_exempt?: false,
          imported?: false
        )
      end
    end

    context 'when the input is "1 packet of headache pills at 9.75"' do
      let(:input) { '1 packet of headache pills at 9.75' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 1,
          name: 'packet of headache pills',
          price: 9.75,
          tax_exempt?: true,
          imported?: false
        )
      end
    end

    context 'when the input is "3 imported boxes of chocolates at 11.25"' do
      let(:input) { '3 imported boxes of chocolates at 11.25' }
      let(:item) { ItemBuilder.item(input) }

      it 'builds an item with the correct attributes' do
        expect(item).to have_attributes(
          quantity: 3,
          name: 'imported boxes of chocolates',
          price: 11.25,
          tax_exempt?: true,
          imported?: true
        )
      end
    end
  end
end
