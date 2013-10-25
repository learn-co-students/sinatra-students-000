Sequel.migration do
  up do
    add_column :students, :profile_image, String
    add_column :students, :background_image, String
    add_column :students, :twitter, String
    add_column :students, :linkedin, String
    add_column :students, :github, String
    add_column :students, :quote, String
    add_column :students, :bio, String
    add_column :students, :work, String
    add_column :students, :work_title, String
    add_column :students, :education, String
  end

  down do
    remove_column :students, :profile_image
    remove_column :students, :background_image
    remove_column :students, :twitter
    remove_column :students, :linkedin
    remove_column :students, :github
    remove_column :students, :quote
    remove_column :students, :bio
    remove_column :students, :work
    remove_column :students, :work_title
    remove_column :students, :education
  end
end