class AddSlugToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :slug, :string
    add_index  :categories, :slug
  end
end
