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

  get '/students/new' do
    erb :'students/new'
  end

  post '/students' do
    @student = Student.create(name: params[:student][:name], twitter: params[:student][:twitter], linkedin: params[:student][:linkedin], github: params[:student][:github], quote: params[:student][:quote], bio: params[:student][:bio], work_title: params[:student][:work_title], education: params[:student][:education])
    @student.slug = @student.to_slug(params[:student][:name])
    @student.work = "Coming Sooner than you think..."
    @student.save
    redirect "/"
  end

  get '/students/:slug/edit' do
    @student = Student.find_by(slug: params[:slug]) 
    erb :'students/edit'
  end

  get '/students/:slug' do
    @student = Student.find_by(slug: params[:slug])
    erb :'students/show'
  end

  post '/students/:slug' do
    student = Student.find_by(slug: params[:slug])
    # should have used #update here. Oh well, it works, time to move on.
    id = student.id
    slug = student.slug
    work = student.work
    student.destroy
    Student.create(id: id, slug: slug, work: work, name: params[:student][:name], twitter: params[:student][:twitter], linkedin: params[:student][:linkedin], github: params[:student][:github], quote: params[:student][:quote], bio: params[:student][:bio], work_title: params[:student][:work_title], education: params[:student][:education])
    redirect "students/#{params[:slug]}"
  end

end
