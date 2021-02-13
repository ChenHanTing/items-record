module Admin
  class ItemSerializer < ::ActiveModel::Serializer
    attributes :id, :name, :quantity, :price, :remark, :user_email, :vendor

    def user_email
      object.user.email
    end
  end
end