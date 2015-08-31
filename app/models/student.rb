class Student < ActiveRecord::Base

	before_create do		
		self.slug = self.to_slug(self.name)
	end

	def to_slug(student_name)
    student_name.downcase.split.join('-')
  end

end