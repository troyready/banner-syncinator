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

  describe '#hash' do
    let(:attrs) { [:test, 'Test'] }
    let(:eql_affiliation) { Affiliation.new(*attrs) }
    its(:hash) { should eql eql_affiliation.hash }
  end

  describe '#eql?' do
    let(:attrs) { [:test, 'Test'] }
    let(:eql_affiliation) { Affiliation.new(*attrs) }
    it { expect(subject.eql? eql_affiliation).to be true }
  end

  describe '#attributes' do
    let(:student) { Affiliation.new(:student, 'Student') }
    let(:accepted_student) { Affiliation.new(:accepted_student, 'Accepted Student') }

    it "includes it's own custom attributes" do
      expect(student.attributes).to include :last_name
      expect(student.attributes).to include :majors
    end

    it "does not include other affiliation's attributes" do
      expect(accepted_student.attributes).to include :last_name
      expect(accepted_student.attributes).to_not include :majors
    end
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
