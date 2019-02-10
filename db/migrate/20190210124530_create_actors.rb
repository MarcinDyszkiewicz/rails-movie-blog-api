class CreateActors < ActiveRecord::Migration[5.2]
  def change
    create_table :actors do |t|
      t.string :slug, null: false, unique: true
      t.string :full_name, null: false
      t.string :poster

      t.timestamps
    end
  end
end
