# frozen_string_literal: true

# SlugsController handles redirects for mybit.ly/foo123 type requests.
# This is not a JSON API and does not need to be versioned.
class SlugsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:catch]

  def catch
    shortlink = Shortlink.find_by(slug: catch_params[:slug])

    if shortlink
      Shortlink.increment_counter(:click_count, shortlink) # atomic
      redirect_to(shortlink.source)
    else
      render({ status: :not_found })
    end
  end

  private

  def catch_params
    params.permit(:slug)
  end
end
