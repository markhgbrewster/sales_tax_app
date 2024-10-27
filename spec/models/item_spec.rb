# frozen_string_literal: true

require_relative '../../models/item'

RSpec.describe Item do
  describe '#initialize' do
    let(:item) { Item.new(quantity: 2, name: 'book', price: 12.49, tax_exempt: true, imported: false) }

    it 'sets the correct attributes on initialization' do
      expect(item.quantity).to eq(2)
      expect(item.name).to eq('book')
      expect(item.price).to eq(12.49)
    end
  end

  describe '#imported?' do
    context 'when the item is imported' do
      let(:item) do
        Item.new(quantity: 1, name: 'imported bottle of perfume', price: 47.50, tax_exempt: false, imported: true)
      end

      it 'returns true' do
        expect(item.imported?).to be true
      end
    end

    context 'when the item is not imported' do
      let(:item) { Item.new(quantity: 1, name: 'bottle of perfume', price: 18.99, tax_exempt: false, imported: false) }

      it 'returns false' do
        expect(item.imported?).to be false
      end
    end

    context 'when imported is not a boolean' do
      let(:item) do
        Item.new(quantity: 1, name: 'bottle of perfume', price: 18.99, tax_exempt: false, imported: 'some rubbish')
      end

      it 'returns false' do
        expect(item.imported?).to be false
      end
    end
  end

  describe '#tax_exempt?' do
    context 'when the item is tax exempt' do
      let(:item) { Item.new(quantity: 1, name: 'book', price: 12.49, tax_exempt: true, imported: false) }

      it 'returns true' do
        expect(item.tax_exempt?).to be true
      end
    end

    context 'when the item is not tax exempt' do
      let(:item) { Item.new(quantity: 1, name: 'music CD', price: 14.99, tax_exempt: false, imported: false) }

      it 'returns false' do
        expect(item.tax_exempt?).to be false
      end
    end

    context 'when tax_exempt is not a boolean' do
      let(:item) do
        Item.new(quantity: 1, name: 'bottle of perfume', price: 18.99, tax_exempt: 'some rubbish', imported: false)
      end

      it 'returns false' do
        expect(item.tax_exempt?).to be false
      end
    end
  end
end
