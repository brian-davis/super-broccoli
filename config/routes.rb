# http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :shortlinks, only: [:create]

  get('*slug', {
    to: 'shortlinks#catch',
    constraints: { slug: ShortlinkFormatter::Slug.matcher }
  })
end
