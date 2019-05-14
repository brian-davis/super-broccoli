require 'rails_helper'

RSpec.describe ShortlinksController, type: :controller do
  describe 'POST #create' do
    let(:current_user) { FactoryBot.create(:user) }

    context 'with valid params' do
      it 'requires authorization' do
        attrs = FactoryBot.attributes_for(:shortlink)
        post_params = { shortlink: attrs }
        request.headers['Auth-Token'] = ''

        expect do
          post(:create, { params: post_params, format: :json })
        end.to change { Shortlink.count }.by(0)
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns http created' do
        attrs = FactoryBot.attributes_for(:shortlink)
        # => {:source=>"http://johnston.biz/hilton.treutel"}

        post_params = { shortlink: attrs }
        request.headers['Auth-Token'] = current_user.auth_token

        expect do
          post(:create, { params: post_params, format: :json })
        end.to change { Shortlink.count }.by(1)
        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response.dig('shortlink', 'source')).to eq(attrs[:source])
        expect(json_response.dig('shortlink', 'slug')).to match(/[a-zA-Z0-9\-_]{6}/)
      end

      # TODO: scope to tenant once multitenant
      it 'will return an existing record if given a duplicate source url' do
        existing_record = FactoryBot.create(:shortlink)

        post_params = { shortlink: { source: existing_record.source } }
        # headers = { 'Auth-Token' => current_user.auth_token }
        request.headers['Auth-Token'] = current_user.auth_token

        expect do
          post(:create, { params: post_params, format: :json })
        end.to change { Shortlink.count }.by(0)

        expect(response).to have_http_status(:ok) # not :created
        json_response = JSON.parse(response.body)
        expect(json_response.dig('shortlink', 'source')).to eq(existing_record.source)
        expect(json_response.dig('shortlink', 'slug')).to eq(existing_record.slug)
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        request.headers['Auth-Token'] = current_user.auth_token
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
