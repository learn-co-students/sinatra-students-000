require_relative '../spec_helper'

describe Student do
  context 'with slugs' do
    describe '#slugify!' do
      it "formats a slug based on a student's name" do
        # Remember that subject will by default be a new instance
        # of the class being described.
        subject.name = 'Avi "TheBoss" Flombaum'
        subject.slugify!

        expect(subject.slug).to eq('avi-theboss-flombaum')
      end

      it 'saves the slug to the database on create' do
        # You will need to read this and learn about model hooks.
        # http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
        # http://edgeguides.rubyonrails.org/active_record_callbacks.html
        subject.name = "Avi Flombaum"
        subject.save

        expect(subject.slug).to eq('avi-flombaum')
        expect(Student.find_by(:slug => "avi-flombaum")).to eq(subject)
      end
    end
  end
end
