class AddStudentsSlug < ActiveRecord::Migration
  def change
  	change_table :students do |t|
  	  t.string :slug
  	end
  end
end