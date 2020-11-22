class AddPlaceAreaToRecruitments < ActiveRecord::Migration[5.2]
  def change
    add_column :recruitments, :place_area, :string
  end
end
