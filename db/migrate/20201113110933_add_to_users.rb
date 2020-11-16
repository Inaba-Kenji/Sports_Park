class AddToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :profile_image_id, :string
    add_column :users, :is_deleted, :boolean, default: false
    add_column :users, :introduction, :text
    add_column :users, :favorites_sports, :string
  end
end
