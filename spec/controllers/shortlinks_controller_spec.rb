require 'rails_helper'

RSpec.describe ShortlinksController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      it 'returns http created' do
        post_params = { shortlink: { source: 'https://www.example.com' } }
        expect do
          post(:create, { params: post_params, format: :json })
        end.to change { Shortlink.count }.by(1)
        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response.dig('shortlink', 'source')).to eq(post_params.dig(:shortlink, :source))
        expect(json_response.dig('shortlink', 'slug')).to match(/[a-zA-Z0-9\-_]{6}/)
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        post_params = { shortlink: { source: '' } }

        expect do
          post(:create, { params: post_params, format: :json })
        end.not_to change { Shortlink.count }

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
        expect("Source can't be blank").to be_in(json_response['errors'])
      end
    end
  end

  describe 'GET #catch' do
    # see link_shortener_api/spec/requests/shortlinks_catch_spec.rb
  end
end
