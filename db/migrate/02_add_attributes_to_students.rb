class AddAttributesToStudents < ActiveRecord::Migration
  def change
    create_table :students do |s|
      s.string :name
      s.string :profile_image
      s.string :background_image
      s.string :twitter
      s.string :linkedin
      s.string :github
      s.string :quote
      s.string :bio
      s.string :work
      s.string :work_title
      s.string :education
    end
  end
end
