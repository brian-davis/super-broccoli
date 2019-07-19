# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'slugs catch', type: :request do
  describe 'GET #catch' do
    let(:shortlink) { FactoryBot.create(:shortlink) }

    context 'valid' do
      it 'matches a shortlink dynamically based on slug' do
        source = shortlink.source
        slug = shortlink.slug
        get "/#{slug}"
        expect(response).to redirect_to(source)
      end

      describe 'click tracking' do
        it 'increments the click_count' do
          before_count = shortlink.click_count
          get "/#{shortlink.slug}"
          shortlink.reload
          after_count = shortlink.click_count
          expect(after_count - before_count).to eq(1)
        end

        it 'builds attrs for the click' do
          mock_user_agent = 'A Browser'
          mock_referer = 'The Internet'

          allow_any_instance_of(ActionDispatch::Request).to(
            receive(:user_agent).and_return(mock_user_agent)
          )
          allow_any_instance_of(ActionDispatch::Request).to(
            receive(:referer).and_return(mock_referer)
          )

          get "/#{shortlink.slug}"
          new_click = shortlink.clicks.last
          expect(new_click.ip_address).to eq('127.0.0.1')
          expect(new_click.user_agent).to eq(mock_user_agent)
          expect(new_click.referer).to eq(mock_referer)
        end
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
