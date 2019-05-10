class ShortlinksController < ApplicationController
  def create
    shortlink = Shortlink.new(create_params)
    if shortlink.save
      render({
        json: shortlink.to_json,
        status: :created
      })
    else
      errors = shortlink.errors.full_messages
      render({ json: { errors: errors }, status: :unprocessable_entity })
    end
  end

  def catch
    shortlink = Shortlink.find_by(slug: catch_params[:slug])
    if shortlink && shortlink.source
      Shortlink.increment_counter(:click_count, shortlink) # atomic

      redirect_to(shortlink.source)
    else
      render({ status: :not_found })
    end
  end

  private

  def create_params
    params.require(:shortlink).permit(:source)
  end

  def catch_params
    params.permit(:slug)
  end
end
