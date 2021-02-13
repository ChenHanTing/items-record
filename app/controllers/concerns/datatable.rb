module Datatable
  # 用法: https://api.rubyonrails.org/v6.1.0/classes/ActiveSupport/Concern.html
  extend ActiveSupport::Concern
  included do
    controller = self.controller_name

    define_method(controller) do
      case controller
      when 'items'
        @itemss ||= Item.includes(:user)
      else
        instance_variable_set("@#{controller}", controller.camelize.singularize.constantize)
      end
    end

    define_method(:index) do
      respond_to do |format|
        # self.send(controller) is method defined above
        filtered_objects = self.send(controller).ransack(search_params).result
        # Logger
        Rails.logger.info("The quantity of filtered_objects: #{filtered_objects.count}")
        Rails.logger.info("SQL in  filtered_objects: #{filtered_objects.to_sql}")
        # return value
        format.html { render :index }
        format.json {
          render json: {
            draw: params[:draw].to_i,
            recordsTotal: self.send(controller).count,
            recordsFiltered: filtered_objects.count,
            data: viewable_lists(filtered_objects)
          }
        }
      end
    end

    # 預設資料拼法
    define_method(:default_viewable_lists) do |filtered_sub_orders, keys|
      data_lists(viewable(filtered_sub_orders), "Admin::#{controller.classify}Serializer".constantize, keys)
    end
  end

  # 可視資料
  def viewable(scope)
    scope.offset(params[:start].to_i).limit(params[:length].to_i).order(id: :desc)
  end

  # 組 datatable 資料
  def data_lists(object, serializer, keys)
    object.map { |each_object| serializer.new(each_object).attributes }
          .map { |el| [].tap { |col| keys.each { |k| k.class.eql?(Array) ? col << k.map { |l| el[l] } : col << el[k] } } }
  end
end