module Api
  module V1
    class ContactController < ApplicationController
      skip_before_action :doorkeeper_authorize!

      def create
        # Errno::ECONNREFUSED – Connection refused – connect(2) for “localhost” port 25
        ContactMailer.contact_email(
          params[:title],
          params[:content],
          params[:email],
          params[:source]).deliver_later

        ContactMailer.contact_email(
          params[:title],
          params[:content],
          params[:email],
          params[:source]).deliver_now

        Contact.create(
          title: params[:title],
          content: params[:content],
          email: params[:email],
          source: params[:source]
        )

        render json: { success: true }
      end
    end
  end
end
