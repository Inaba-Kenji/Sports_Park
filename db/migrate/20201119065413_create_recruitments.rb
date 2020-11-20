class CreateRecruitments < ActiveRecord::Migration[5.2]
  def change
    create_table :recruitments do |t|
      t.string :title
      t.string :place
      t.string :price
      t.string :event_date

      t.timestamps
    end
  end
end
