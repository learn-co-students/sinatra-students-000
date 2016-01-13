# StudentsController inherits from ApplicationController
# so any settings defined there will apply to this controller.
class StudentsController < ApplicationController
  # GET '/'
  get '/' do
    # Homepage action to display the student index.
    # Load all the students into an instance variable.
    # We use the ::all method on the Student class, provided by Sequel
    @students = Student.all
    erb :'students/index' # render the index.erb within app/views/students
  end

  # Build the rest of the routes here.

  # GET '/students/new'
  get '/students/new' do
    erb :'students/new'
  end  

  # POST '/students'
  post '/students' do
    student_params = {}
    [:name, :bio, :quote, :education, :twitter, :linkedin, :github].each do |column_name|
      student_params[column_name] = params[column_name]
    end
    @student = Student.create(student_params)
    redirect to("/students/#{@student.slug}")
  end  
  
  # GET '/students/avi-flombaum'
  get '/students/:slug' do
    @student = Student.find_by(slug: params[:slug])
    erb :'students/show'
  end
    
  # GET '/students/avi-flombaum/edit'
  get '/students/:slug/edit' do
    @student = Student.find_by(slug: params[:slug])
    erb :'students/edit'
  end

  # POST '/students/avi-flombaum'
  post '/students/:slug' do
    @student = Student.find_by(slug: params[:slug])
    Student.column_names.each do |column_name|
      @student[column_name] = params[column_name] if params[column_name]
    end
    @student.save
    redirect to("/students/#{@student.slug}")
  end
end
