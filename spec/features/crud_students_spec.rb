require_relative '../feature_helper'
Capybara.app = StudentsController

feature "Viewing students" do
  given!(:student_1){Student.create(:name => "Flatiron Student 1")}
  given!(:student_2){Student.create(:name => "Flatiron Student 2")}

  background do
    visit '/'
  end

  scenario 'visiting the index' do
    expect(page).to have_content student_1.name
    expect(page).to have_content student_2.name
  end

  scenario 'visiting a student profile' do
    click_link "Flatiron Student 1"
    expect(page).to have_content student_1.name
    expect(current_path).to include(student_1.slug)
  end
end

feature "Creating a student" do
  background do
    visit '/students/new'
  end

  scenario "submitting the new student form" do
    within("form#new_student") do 
      fill_in "student[name]", :with => "Flatiron Student"
      click_button 'Create Student'
    end
    expect(page).to have_content 'Flatiron Student'
    expect(current_path).to include('flatiron-student')
  end
end

feature 'Editing a student' do
  given!(:student_1){Student.create(:name => "Flatiron Student 1")}

  background do
    visit "/students/#{student_1.slug}/edit"
  end

  scenario "submitting the edit student form" do
    within("form#edit_student") do
      fill_in "student[name]", :with => "Update Student 1"
      click_button "Update Student"
    end
    expect(page).to have_content 'Update Student 1'
  end
end
