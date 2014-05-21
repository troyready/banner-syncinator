require 'spec_helper'

describe BannerSyncinator::NullPerson do
  its(:present?) { should be_false }
  its(:blank?) { should be_true }
  its(:to_ary) { should eql [] }
  its(:to_s) { should eql '' }
  its(:attributes) { should be_a Hash }
  its('attributes.values.uniq') { should eql [nil] }
  its('attributes') { should have_key :first_name }

  [:is?, :eql?, :==].each do |method|
    describe '#is?' do
      subject { BannerSyncinator::NullPerson.new.send(method, other) }

      context 'when comparing some other object' do
        let(:other) { Object.new }
        it { should be_false }
      end

      context 'when comparing another NullPerson' do
        let(:other) { BannerSyncinator::NullPerson.new }
        it { should be_true }
      end
    end
  end

  describe '#method_missing' do
    subject { BannerSyncinator::NullPerson.new.whatever }
    it { should be_nil }
  end

  its(:hash) { should eql 0.hash }
end