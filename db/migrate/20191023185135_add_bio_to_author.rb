class AddBioToAuthor < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :biography, :string
  end
end
