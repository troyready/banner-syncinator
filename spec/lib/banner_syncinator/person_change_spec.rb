require 'spec_helper'

describe PersonChange do
  let(:old_attrs) { {} }
  let(:new_attrs) { {} }
  let(:old_person) { Trogdir::Person.new(old_attrs) }
  let(:new_person) { Banner::Person.new(new_attrs) }
  let(:person_change) { PersonChange.new(old_person, new_person) }
  subject { person_change }

  describe '#diff' do
    let(:old_attrs) { {FNAME: 'John', LNAME: 'Doe'} }

    context 'when the same attributes' do
      let(:new_attrs) { {first_name: 'John', last_name: 'Doe'} }

      its(:diff) { should eql({}) }
    end

    context 'when different attributes' do
      let(:new_attrs) { {first_name: 'Johnny', last_name: 'Doe'} }

      its(:diff) { {first_name: {old: 'John', new: 'Johnny'}} }
    end
  end
end