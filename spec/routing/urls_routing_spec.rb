require 'rails_helper'

RSpec.describe 'routes for shortlinks', type: :routing do
  it 'routes POST /shortlinks to shortlinks#create' do
    expect(post: '/shortlinks').to route_to('shortlinks#create')
  end

  it 'tries to match an unknown slugs to a shortlink resource' do
    shortlink = FactoryBot.create(:shortlink)

    expect(get: "/#{shortlink.slug}").to route_to({
      controller:    'shortlinks',
      action:        'catch',
      slug:          "#{shortlink.slug}"
    })
  end

  it 'rejects paths not matching the slug format' do
    expect(get: '/abc123123').not_to route_to({
      controller: 'shortlinks',
      action:     'catch'
    })
  end
end
