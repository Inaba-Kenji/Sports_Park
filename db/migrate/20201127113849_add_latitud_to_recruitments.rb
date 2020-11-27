class AddLatitudToRecruitments < ActiveRecord::Migration[5.2]
  def change
    add_column :recruitments, :latitude, :float
    add_column :recruitments, :longitude, :float
  end
end
