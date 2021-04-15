# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  content    :text
#  email      :string
#  source     :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
  enum source: {
    sweat_nonstop: 0,
    lab911: 1
  }
end
