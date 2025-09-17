require 'rails_helper'

RSpec.describe StringCalculator, type: :service do
describe '#add' do
it 'returns 0 for an empty string' do
expect(StringCalculator.new.add('')).to eq 0
end

it 'returns the number for a single number string' do
expect(StringCalculator.new.add('4')).to eq 4
end

it 'returns the sum for two numbers separated by comma' do
expect(StringCalculator.new.add('1,5')).to eq 6
end

it 'allows any amount of numbers' do
expect(StringCalculator.new.add('1,2,3,4')).to eq 10
end

it 'handles newlines between numbers as delimiters' do
expect(StringCalculator.new.add("1\n2,3")).to eq 6
end

it 'supports custom single-character delimiter specified in header' do
expect(StringCalculator.new.add("//;\n1;2")).to eq 3
end

it 'raises an error for negative numbers and shows all negatives in message' do
expect { StringCalculator.new.add('1,-2,3,-4') }.to raise_error(ArgumentError, 'negative numbers not allowed -2,-4')
end
end
end