class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :slug, unique: true
      t.string :name, unique: true

      t.timestamps
    end
  end
end
