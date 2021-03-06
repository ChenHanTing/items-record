# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  features   :jsonb
#  name       :string
#  price      :integer
#  quantity   :integer
#  remark     :string
#  vendor     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :pictures

  after_commit :save_dimensions

  private

  def save_dimensions
    self.pictures.each { _1.analyze unless _1.analyzed? }
  end
end
