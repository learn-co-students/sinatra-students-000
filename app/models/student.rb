class Student < ActiveRecord::Base
  
  before_create :slugify! 

  def slugify!
  	self.slug = name.downcase.gsub(/\"/, "").split(" ").join("-")
  end

end