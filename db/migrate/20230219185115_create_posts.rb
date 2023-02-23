class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :customer_id
      t.integer :genre_id
      t.string  :name
      t.text    :subject
      t.text    :introduction
      t.boolean :is_active

      t.timestamps
    end
  end
end
