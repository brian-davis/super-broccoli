require 'rails_helper'

RSpec.describe 'shortlinks catch', type: :request do
  describe 'GET #catch' do
    context 'valid' do
      it 'matches a shortlink dynamically based on slug' do
        shortlink = FactoryBot.create(:shortlink)
        source = shortlink.source
        slug = shortlink.slug

        get "/#{slug}"
        expect(response).to redirect_to(source)
      end

      it 'increments the click_count' do
        shortlink = FactoryBot.create(:shortlink)
        before_count = shortlink.click_count
        get "/#{shortlink.slug}"
        shortlink.reload
        after_count = shortlink.click_count
        expect(after_count - before_count).to eq(1)
      end
    end

    context 'missing' do
      it 'matches a shortlink dynamically based on slug' do
        get '/abc123'
        expect(response.status).to eq(404)
      end
    end
  end
end
