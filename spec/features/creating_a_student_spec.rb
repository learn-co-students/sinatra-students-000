require_relative '../feature_helper'
Capybara.app = StudentsController

feature "Creating a student" do
  background do
    visit '/students/new'
  end

  scenario "submitting the new student form" do
    within("#new_student") do 
      fill_in "Name", :with => "Flatiron School"
      click_link 'Create Student'
    end
    expect(page).to have_content 'Flatiron School'
  end
end
