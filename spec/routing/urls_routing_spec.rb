# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for shortlinks', type: :routing do
  context 'JSON API' do
    it 'routes POST /api/v1/shortlinks to shortlinks#create' do
      expected = { controller: 'api/v1/shortlinks', action: 'create' }
      expect(post: '/api/v1/shortlinks').to route_to(expected)
    end
  end

  context 'public redirector' do
    it 'tries to match an unknown slug to a shortlink resource' do
      shortlink = FactoryBot.create(:shortlink)
      expected = { controller: 'slugs', action: 'catch', slug: shortlink.slug }
      expect(get: "/#{shortlink.slug}").to route_to(expected)
    end

    it 'rejects paths not matching the slug format' do
      bad_slug = 'a' * (ShortlinkFormatter::Slug::SLUG_SIZE + 1)
      expected = { controller: 'slugs', action: 'catch' }
      expect(get: "/#{bad_slug}").not_to route_to(expected)
    end
  end
end
