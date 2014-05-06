require 'spec_helper'

describe Banner::Person do
  let(:params) { {} }
  subject { Banner::Person.new(params) }

  describe '#banner_id' do
    let(:params) { {PIDM: 42} }
    its(:banner_id) { should eql 42 }
  end

  describe '#biola_id' do
    let(:params) { {ID: 1234567} }
    its(:biola_id) { should eql 1234567 }
  end

  describe '#last_name' do
    let(:params) { {LNAME: 'Z'} }
    its(:last_name) { should eql 'Z' }
  end

  describe '#first_name' do
    let(:params) { {FNAME: 'Coach'} }
    its(:first_name) { should eql 'Coach' }
  end

  describe '#middle_name' do
    let(:params) { {MNAME: 'O'} }
    its(:middle_name) { should eql 'O' }
  end

  describe '#preferred_name' do
    let(:params) { {PNAME: 'Coachie'} }
    its(:preferred_name) { should eql 'Coachie' }
  end

  describe '#partial_ssn' do
    let(:params) { {SSN: '123-12-1234'} }
    its(:partial_ssn) { should eql '123-12-1234' }
  end

  describe '#street_1' do
    let(:params) { {STREET1: '1 Field St.'} }
    its(:street_1) { should eql '1 Field St.' }
  end

  describe '#street_2' do
    let(:params) { {STREET2: 'Apt B'} }
    its(:street_2) { should eql 'Apt B' }
  end

  describe '#city' do
    let(:params) { {CITY: 'Hometown'} }
    its(:city) { should eql 'Hometown' }
  end

  describe '#state' do
    let(:params) { {STATE: 'Strong Badia'} }
    its(:state) { should eql 'Strong Badia' }
  end

  describe '#zip' do
    let(:params) { {ZIP: '12345'} }
    its(:zip) { should eql '12345' }
  end

  describe '#country' do
    let(:params) { {NATION: 'USA'} }
    its(:country) { should eql 'USA' }
  end

  describe '#university_email' do
    let(:params) { {EMAIL: 'coach.z@example.com'} }
    its(:university_email) { should eql 'coach.z@example.com' }
  end

  describe '#personal_email' do
    let(:params) { {EMAIL_PER: 'dacoach@example.com'} }
    its(:personal_email) { should eql 'dacoach@example.com' }
  end

  describe '#gender' do
    context "when 'M'" do
      let(:params) { {GENDER: 'M'} }
      its(:gender) { should eql :male }
    end

    context "when 'F'" do
      let(:params) { {GENDER: 'F'} }
      its(:gender) { should eql :female }
    end

    context "when nil" do
      let(:params) { {GENDER: nil} }
      its(:gender) { should eql nil }
    end
  end

  describe '#birth_date' do
    context 'when a date' do
      let(:params) { {DOB: '01/01/1970'} }
      its(:birth_date) { should eql Date.new(1970, 1, 1) }
    end

    context 'when nil' do
      let(:params) { {DOB: nil} }
      its(:birth_date) { should eql nil }
    end
  end

  describe '#privacy' do
    context "when 'Y'" do
      let(:params) { {CONFID: 'Y'} }
      its(:privacy) { should eql true }
    end

    context "when 'N'" do
      let(:params) { {CONFID: 'N'} }
      its(:privacy) { should eql false }
    end

    context 'when nil' do
      let(:params) { {CONFID: nil} }
      its(:privacy) { should eql false }
    end
  end
end