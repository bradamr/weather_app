require 'rails_helper'

describe WeatherForecastsController do
  describe 'GET search' do
    context 'with valid address' do
      let(:address_params) do
        { street: 'asdf', city: 'asdf', state: 'as', zip: '12345' }
      end

      it 'returns a successful WeatherCast response' do
        get :search, params: { address: address_params }, as: :json

        expect(response).to have_http_status(:success)
      end

      it 'contains a forecast and cached value' do
        get :search, params: { address: address_params }, as: :json

        expect(response.parsed_body.key?('forecast')).to eq(true)
        expect(response.parsed_body.key?('cached')).to eq(true)
      end

      context 'when call for cached value' do
        let(:cache_key) { 'abcdefgh1234567' }
        let(:address) do
          double(valid?: true, cache_key: cache_key, street: 'abcd', city: 'Chicago', state:
            'IL', zip: '12345')
        end

        before { allow(Address).to receive(:new).and_return(address) }

        it 'returns a cached response' do
          get :search, params: { address: address_params }, as: :json

          expect(Rails.cache.fetch(address.cache_key))
        end
      end
    end

    context 'with invalid address' do
      let(:address_params) do
        { street: 'asdf', city: 'asdf', state: 'as', zip: '1234' }
      end
      it 'returns with an error about the address information' do
        get :search, params: { address: address_params }, as: :json

        expect(response.parsed_body.key?('error')).to eq(true)
      end
    end
  end
end
