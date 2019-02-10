class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.references :commentable, polymorphic: true, index: true
      t.integer :comment_parent_id
      t.text :body
      t.boolean :is_spoiler, default: false

      t.timestamps
    end
  end
end
