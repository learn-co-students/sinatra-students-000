require_relative '../spec_helper'

describe Student do
  context 'with slugs' do
    describe '#slugify!' do
      it 'saves the slug to the database on create' do
        # You will need to read this and learn about model hooks.
        # http://sequel.rubyforge.org/rdoc/files/doc/model_hooks_rdoc.html

        subject.name = "Avi Flombaum"
        subject.save

        expect(subject.slug).to eq('avi-flombaum')
        expect(Student.find(:slug => "avi-flombaum")).to eq(subject)
      end
    end
  end

  context 'normalizing profile images' do
    context 'when creating a new student' do
      subject{Student.create(:profile_image => '../img/alex_chiu_profile_pic.jpg', :name => "Alex Chiu")}        

      it 'normalizes the profile image' do
        expect(subject.profile_image).to eq("http://students.flatironschool.com/img/alex_chiu_profile_pic.jpg")
      end
    end

    context 'with relative images' do
      subject{Student.new(:profile_image => '../img/alex_chiu_profile_pic.jpg')}

      describe '#normalize_profile_image' do
        it 'transforms a relative path to a full path' do
          subject.normalize_profile_image

          expect(subject.profile_image).to eq("http://students.flatironschool.com/img/alex_chiu_profile_pic.jpg")
        end

        it 'skips students with no profile image' do
          subject.profile_image = nil
          expect(subject.normalize_profile_image).to be_nil
        end
      end
    end
  end
end
