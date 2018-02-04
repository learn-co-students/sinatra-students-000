class Student < ActiveRecord::Base

  before_save :slugify!

  def slugify!
    if self.name != nil
      self.slug = self.name.downcase.gsub(" ","-")
    end
  end

end
