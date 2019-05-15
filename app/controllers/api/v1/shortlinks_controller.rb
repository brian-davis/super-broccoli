# frozen_string_literal: true

module Api
  module V1
    # Api::V1::ShortlinksController allows authorized application users to
    # create shareable shortlinks. This is a versioned JSON API.
    class ShortlinksController < ApplicationController
      def create
        shortlink = current_user.shortlinks.find_or_create_by(create_params)
        if shortlink.save
          render({ json: shortlink.to_json, status: :created })
        else
          errors = shortlink.errors.full_messages
          render({ json: { errors: errors }, status: :unprocessable_entity })
        end
      end

      private

      def create_params
        params.require(:shortlink).permit(:source)
      end
    end
  end
end
