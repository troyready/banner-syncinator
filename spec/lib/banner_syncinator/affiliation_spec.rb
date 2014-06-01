require 'spec_helper'

describe Affiliation do
  let(:attrs) { [nil, nil] }
  let(:affilation) { Affiliation.new(*attrs) }

  subject { affilation }

  describe '#slug' do
    let(:attrs) { [:test, 'blah'] }
    its(:slug) { should eql :test }
  end

  describe '#name' do
    let(:attrs) { [:blah, 'test'] }
    its(:name) { should eql 'test' }
  end

  describe '#banner_person' do
    let(:attrs) { [:volunteer, 'volunteer'] }
    its(:banner_person) { should eql Banner::Volunteer }
  end

  describe '#trogdir_person' do
    let(:attrs) { [:volunteer, 'volunteer'] }
    its(:trogdir_person) { should eql Trogdir::Volunteer }
  end

  describe '.find' do
    subject { Affiliation.find(affiliation_finder) }

    context 'with an invalid affiliation' do
      let(:affiliation_finder) { 'blah' }
      it { expect(subject).to be_nil }
    end

    context 'with an Affiliation' do
      let(:affiliation_finder) { Trogdir::Student.affiliation }
      it { expect(subject.banner_person).to eql Banner::Student }
    end

    context 'with a person class' do
      let(:affiliation_finder) { Banner::AcceptedStudent }
      it { expect(subject.trogdir_person).to eql Trogdir::AcceptedStudent  }
    end

    context 'with an slug' do
      let(:affiliation_finder) { :employee }
      it { expect(subject.banner_person).to eql Banner::Employee }
    end

    context 'with a name' do
      let(:affiliation_finder) { 'student worker' }
      it { expect(subject.trogdir_person).to eql Trogdir::StudentWorker }
    end
  end
end