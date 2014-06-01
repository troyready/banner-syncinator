require 'spec_helper'

describe NullPerson do
  describe '.new' do
    let(:args) { [] }
    subject { NullPerson.new(*args) }

    context 'without default mimick arg' do
      its('attributes.keys') { should eql ::Person::ATTRS }
      it { should_not respond_to :department }
    end

    context 'with Banner::Employee mimick arg' do
      let(:args) { [Banner::Employee] }
      its('attributes.keys') { should eql Banner::Employee::ATTRS }
      it { should respond_to :department }
    end
  end

  its(:present?) { should be_false }
  its(:blank?) { should be_true }
  its(:to_ary) { should eql [] }
  its(:to_s) { should eql '' }
  its(:attributes) { should be_a Hash }
  its('attributes.values.uniq') { should eql [nil] }
  its('attributes') { should have_key :first_name }

  [:is?, :eql?, :==].each do |method|
    describe "##{method}" do
      subject { NullPerson.new.send(method, other) }

      context 'when comparing some other object' do
        let(:other) { Object.new }
        it { should be_false }
      end

      context 'when comparing another NullPerson' do
        let(:other) { NullPerson.new }
        it { should be_true }
      end
    end
  end

  describe '#method_missing' do
    subject { NullPerson.new.whatever }
    it { should be_nil }
  end

  its(:hash) { should eql 0.hash }
end