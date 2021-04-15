class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :title
      t.text :content
      t.string :email
      t.integer :source

      t.timestamps
    end
  end
end
