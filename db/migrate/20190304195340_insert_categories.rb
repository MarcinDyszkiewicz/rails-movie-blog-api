class InsertCategories < ActiveRecord::Migration[5.2]

  def up
    Category.create!(name: "hot", slug: "hot")
    Category.create!(name: "popular", slug: "popular")
  end

  def down
    Category.where(name: "hot").destroy_all
    Category.where(name: "popular").destroy_all
  end
end
