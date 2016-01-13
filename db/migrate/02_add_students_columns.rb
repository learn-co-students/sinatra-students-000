class AddStudentsColumns < ActiveRecord::Migration
  def change
  	change_table :students do |t|
      t.string :profile_image
      t.string :background_image
      t.string :twitter
      t.string :linkedin
      t.string :github
      t.string :quote
      t.text :bio
      t.string :work
      t.string :work_title
      t.string :education
  	end
  end
end