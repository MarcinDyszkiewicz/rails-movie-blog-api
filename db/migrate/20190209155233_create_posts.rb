class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :movie, index: true
      t.string :slug, null: false, uniquess: true
      t.text :title, null: false
      t.text :body, null: false
      t.string :image, null: false
      t.string :meta_title
      t.text :meta_description
      t.text :summary
      t.text :short_description
      t.text :catchy_title
      t.boolean :is_published, default: false
      t.date :published_at

      t.timestamps
    end
    add_index :posts, [:title, :is_published], unique: true
  end
end
