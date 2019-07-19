# frozen_string_literal: true

# SlugsController handles redirects for mybit.ly/foo123 type requests.
# This is not a JSON API and does not need to be versioned.
class SlugsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:catch]

  def catch
    shortlink = Shortlink.find_by(slug: catch_params[:slug])

    if shortlink
      shortlink.clicks.create(click_attrs)
      redirect_to(shortlink.source)
    else
      render({ status: :not_found })
    end
  end

  private

  def click_attrs
    ClickAttributeBuilder[request]
  end

  def catch_params
    params.permit(:slug)
  end
end
