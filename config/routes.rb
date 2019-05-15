# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :shortlinks, only: [:create]
    end
  end

  get('*slug', {
    to: 'slugs#catch',
    constraints: { slug: ShortlinkFormatter::Slug.matcher }
  })
end
