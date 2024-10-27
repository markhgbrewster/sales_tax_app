# frozen_string_literal: true

require_relative '../../lib/tax_calculator'
require_relative '../../models/item'

RSpec.describe TaxCalculator do
  describe '.calculate_tax' do
    context 'when the item is tax exempt and not imported' do
      let(:item) { Item.new(quantity: 1, name: 'book', price: 12.49, tax_exempt: true, imported: false) }

      it 'returns 0 tax' do
        expect(TaxCalculator.calculate_tax(item)).to eq(0.0)
      end
    end

    context 'when the item is not tax exempt and not imported' do
      let(:item) { Item.new(quantity: 1, name: 'music CD', price: 14.99, tax_exempt: false, imported: false) }

      it 'calculates basic sales tax at 10%' do
        expect(TaxCalculator.calculate_tax(item)).to eq(1.5)
      end
    end

    context 'when the item is tax exempt and imported' do
      let(:item) do
        Item.new(quantity: 1, name: 'imported box of chocolates', price: 10.00, tax_exempt: true, imported: true)
      end

      it 'calculates import duty at 5%' do
        expect(TaxCalculator.calculate_tax(item)).to eq(0.5)
      end
    end

    context 'when the item is not tax exempt and is imported' do
      let(:item) do
        Item.new(quantity: 1, name: 'imported bottle of perfume', price: 47.50, tax_exempt: false, imported: true)
      end

      it 'calculates both basic sales tax at 10% and import duty at 5%' do
        expect(TaxCalculator.calculate_tax(item)).to eq(7.15)
      end
    end
  end

  describe '.round_tax' do
    it 'rounds tax up to the nearest 0.05' do
      expect(TaxCalculator.round_tax(1.49)).to eq(1.5)
      expect(TaxCalculator.round_tax(1.50)).to eq(1.5)
      expect(TaxCalculator.round_tax(1.51)).to eq(1.55)
      expect(TaxCalculator.round_tax(0)).to eq(0.0)
    end
  end
end
