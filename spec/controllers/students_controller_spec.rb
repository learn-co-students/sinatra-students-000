require_relative '../spec_helper'

describe StudentsController do
  # Every route should be within it's own context.
  context 'GET /' do
    # student will be a new, unsaved student.
    let(:student){Student.new.tap{|s| s.name = "Flatiron Student"}}
    # As your test suite grows, you might need more sample data to correctly
    # test your controllers. For example, when testing updating a student
    # your test object (student), will have to have been saved and you'll have
    # to compare the original student to the updated student and make sure the
    # correct updates occurred. Feel free to create more test objects as you need.

    # BONUS - Use factory_girl https://github.com/thoughtbot/factory_girl

    # This creates a mock web request to the route '/' so that our tests
    #    can check the response to that request through the Rack::Test provided
    #    method 'last_response', which will always mean the last response
    #    our test suite triggered.
    before do
      student.save
      get '/'
    end

    # A good controller test you can write for every single route/action
    # is to make sure it responds with a 200 status code.
    it 'responds with a 200' do
      # We use the last_response object to test the properties of the response
      # sinatra would send to the request. last_response behaves a lot like an
      # HTTP, with methods to provide a status code and the body of the response
      # A shortcut to checking the status is to just say it is ok with the line below.
      expect(last_response).to be_ok
    end
  
    it 'has the students name in the response' do
      # The body of the last_response is basically the rendered HTML from the view.
      expect(last_response.body).to include(student.name)
    end
  end
  
  context 'GET /students/new' do
    it 'shows the page to add a new student' do
      get '/students/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include("<h2>Adding a New Student</h2>")
    end
  end
  
  context 'POST /students' do
    it 'creates a new Student and saves it to DB' do
      post '/students', {name: "John Doe"}
      follow_redirect!
      expect(last_response).to be_ok
      # persistence
      expect(Student.count).to eq(1)
      expect(Student.take.name).to eq("John Doe")
      # redirect
      expect(last_response.body).to include('<h4 class="ib_main_header">John Doe</h4>')
    end  
  end

  context 'GET /students/slug' do
    params = {name: "John Doe", twitter: "my.twitter", linkedin: "my.linkedin", github: "my.github",
              quote: "Asta La Vista Baby!", bio: "wrote code drinking beer", education: "High", work: "none"}
    let(:student){Student.create(params)}

    before do
      get "/students/#{student.slug}"
    end  

    it 'responds with a 200' do
      expect(last_response).to be_ok
    end
  
    it 'has the students attributes in the response' do
      [:name, :twitter, :linkedin, :github, :quote, :bio, :education, :work].each do |column_name|
        # No need to test presence of student[column_name] if it's value is nil
        expect(last_response.body).to include(student[column_name]) if student[column_name]
      end  
    end
  end

  # This context should only be about testing the edit form.
  context 'GET /students/slug/edit' do
    params = {name: "John Doe", twitter: "my.twitter", linkedin: "my.linkedin", github: "my.github",
              quote: "Asta La Vista Baby!", bio: "wrote code drinking beer", education: "High"}
    let(:student){Student.create(params)}

    before do
      get "/students/#{student.slug}/edit"
    end  

    it 'responds with a 200' do
      expect(last_response).to be_ok
    end
  
    it 'has the students name as a header' do
      expect(last_response.body).to include("<h2>John Doe</h2>")
    end  

    it 'has the students attributes as values of edit fields' do
      [:twitter, :linkedin, :github, :quote, :bio, :education].each do |column_name|
        # No need to test presence of student[column_name] if it's value is nil
        if student[column_name] then
          incl_str = '<input type="text" name="' << "#{column_name}" << '" value="' << "#{student[column_name]}" << '">'
          expect(last_response.body).to include(incl_str)
        end
      end  
    end
  end

  context 'POST /students/slug' do
    params = {name: "John Doe", twitter: "my.twitter", linkedin: "my.linkedin", github: "my.github",
              quote: "Asta La Vista Baby!", bio: "wrote code drinking beer", education: "High"}
    let(:student){Student.create(params)}

    it 'updates a Student and saves it to DB' do
      post "/students/#{student.slug}", {twitter: "no more twitter", quote: "changed"}
      follow_redirect!
      expect(last_response).to be_ok
      # persistence
      changed_student = Student.find_by(slug: student.slug)
      expect(changed_student).to be_a(Student)
      expect(changed_student.name).to eq("John Doe") # still
      expect(changed_student.twitter).to eq("no more twitter") # changed
      expect(changed_student.quote).to eq("changed") # changed
      # redirect
      expect(last_response.body).to include('<h4 class="ib_main_header">John Doe</h4>')
    end  
  end
end