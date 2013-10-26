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
end
