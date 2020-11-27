class AddRecruitmentIntroductionToRecruitments < ActiveRecord::Migration[5.2]
  def change
    add_column :recruitments, :recruitment_introduction, :text
  end
end
