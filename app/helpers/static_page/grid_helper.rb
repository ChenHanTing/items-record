require 'faker'

module StaticPage::GridHelper
  def lorem_sentence
    Faker::Lorem.paragraphs(rand(0..8)).join(' ')
  end
end