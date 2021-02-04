class CreateAdminItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.integer :price
      t.string :remark
      # t.belongs_to :user, null: false, foreign_key: true
      t.string :vendor
      t.jsonb :features

      t.timestamps
    end
  end
end
