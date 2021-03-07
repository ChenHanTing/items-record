module Api
  module V1
    class ItemsController < ApplicationController
      # 會被擋: 403
      # before_action -> { doorkeeper_authorize! :frontend }
      before_action :set_item, only: %i[show update destroy]

      def create
        @item = current_user.items.new item_params

        if @item.save
          render json: { status: :created, location: @item }
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def update
        if @item.update(item_params)
          render json: { status: :created, location: @item }
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def show; end

      private

      # Never trust parameters from the scary internet, only allow the white list through.
      def item_params
        params.permit(:name, :quantity, :price, :remark,
                      :user_id, :vendor, :features, pictures: [])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = Item.find(params[:id])
      end
    end
  end
end
