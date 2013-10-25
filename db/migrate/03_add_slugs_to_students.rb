Sequel.migration do
  up do
    add_column :students, :slug, String
  end

  down do
    remove_column :students, :slug
  end
end