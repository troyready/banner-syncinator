require 'spec_helper'

describe Banner::NonEmployee do
  [Banner::AcceptedStudent, Banner::Alumnus, Banner::Faculty, Banner::Student, Banner::Trustee].each do |klass|
    let(:params) { {} }
    subject { klass.new(params) }

    describe '#partial_ssn' do
      let(:params) { {SSN: '123-12-1234'} }
      its(:partial_ssn) { should eql '123-12-1234' }
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

    describe '#country' do
      let(:params) { {NATION: 'USA'} }
      its(:country) { should eql 'USA' }
    end

    describe '#personal_email' do
      let(:params) { {EMAIL_PERS: 'johnny.doe@example.com'} }
      its(:personal_email) { should eql 'johnny.doe@example.com' }
    end
  end
end