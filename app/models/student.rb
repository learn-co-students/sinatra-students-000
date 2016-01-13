class Student < ActiveRecord::Base

  after_create :slugify!

  def slugify!
    self.slug = self.name.downcase.gsub(" ","-")
    self.save
  end

end