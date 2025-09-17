require 'rails_helper'

RSpec.describe 'StringCalculator API', type: :request do
	it 'returns sum for valid numbers' do
	post '/string_calculator', params: { numbers: '1,2,3' }
	expect(response).to have_http_status(:ok)
	expect(JSON.parse(response.body)['result']).to eq 6
	end

	it 'returns error for negatives' do
	post '/string_calculator', params: { numbers: '1,-2' }
	expect(response).to have_http_status(:unprocessable_entity)
	expect(JSON.parse(response.body)['error']).to eq 'negative numbers not allowed -2'
	end
end