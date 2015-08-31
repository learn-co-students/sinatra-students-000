class CreateStudents < ActiveRecord::Migration
	def change
		create_table :students do |t|
			t.string :name
			t.string :profile_image
			t.string :background_image
			t.string :twitter
			t.string :linkedin
			t.string :github
			t.text   :quote
			t.text   :bio
			t.string :work
			t.string :work_title
			t.string :education
			t.string :slug
		end
	end
end
