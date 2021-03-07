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
  FILE_VALIDATIONS = {
    content_types: %w[application/jpg image/jpeg image/png],
    max_size: 5.megabytes,
    invalid_type: '僅能上傳 jpg jpeg png 檔案',
    invalid_size: '單一圖片限 5Mb 以下'
  }

  belongs_to :user
  has_many_attached :pictures

  after_commit :save_dimensions

  validate :valid_file

  private

  def save_dimensions
    # 若打 postman 使用 analyze 會出現問題:
    # Caused by Errno::ENOENT: No such file or directory @ rb_sysopen
    #
    # self.pictures.each { _1.analyze unless _1.analyzed? }
  end

  def valid_file
    return unless pictures.attached?

    valid_type = pictures.all? { _1.content_type.in? FILE_VALIDATIONS[:content_types] }
    valid_size = pictures.map(&:blob).map(&:byte_size).all? { _1 < FILE_VALIDATIONS[:max_size] }

    if(!valid_type && !valid_size)
      return errors.add(:pics, FILE_VALIDATIONS.slice(:invalid_type, :invalid_size).values.join('，'))
    end

    errors.add(:pics, FILE_VALIDATIONS[:invalid_type]) if !valid_type
    errors.add(:pics, FILE_VALIDATIONS[:invalid_size]) if !valid_size
  end
end

