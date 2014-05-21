require 'spec_helper'

describe BannerSyncinator::Person do
  attrs = BannerSyncinator::Person::ATTRS
  let(:raw_attributes) { {} }
  let(:person) { BannerSyncinator::Person.new(raw_attributes) }
  let(:other_person) { BannerSyncinator::Person.new({}) }
  subject { person }

  attrs.each do |attribute|
    it{ expect { person.send(attribute) }.to raise_exception NotImplementedError }
  end

  [:is?, :eql?].each do |method|
    describe "##{method}" do
      before { person.stub banner_id: 123 }
      subject { person.send(method, other_person) }

      context 'when comparing some other object' do
        let(:other_person) { Object.new }
        it { should be_false }
      end

      context 'when comparing another Person with a different #banner_id' do
        before { other_person.stub banner_id: 321 }
        it { should be_false }
      end

      context 'when comparing another Person with the same #banner_id' do
        before { other_person.stub banner_id: 123 }
        it { should be_true }
      end
    end
  end

  describe '#hash' do
    before { person.stub banner_id: 123 }

    context 'with two different things' do
      before { other_person.stub banner_id: 321 }
      its(:hash) { should_not eql other_person.hash }
    end

    context 'with two equal things' do
      before { other_person.stub banner_id: 123 }
      its(:hash) { should eql other_person.hash }
    end
  end

  describe '#==' do
    subject { person == other_person }

    before do
      attrs.each_with_index do |att|
        val = Faker::Lorem.word
        person.stub att => val
        other_person.stub att => val
      end
    end

    context 'when comparing some other object' do
      let(:other_person) { Object.new }
      it { should be_false }
    end

    context 'when comparing people with different attributes' do
      before { other_person.stub first_name: 'Different' }
      it { should be_false }
    end
    context 'when comparing people the same attributes' do
      it { should be_true }
    end
  end

  describe '#to_s' do
    before { person.stub first_name: 'Trogdor', last_name: 'Burninator' }
    its(:to_s) { should eql 'Trogdor Burninator' }
  end

  it { expect { BannerSyncinator::Person.collection }.to raise_exception NotImplementedError }
end