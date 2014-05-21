require 'spec_helper'

describe Banner::Employee do
  let(:params) { {} }
  let(:employee) { Banner::Employee.new(params) }
  subject { employee }

  describe '#pay_type' do
    let(:params) { {PAYID: '02'} }
    its(:pay_type) { should eql '02' }
    it { expect(employee.attributes[:pay_type]).to eql '02' }
  end

  describe '#department' do
    let(:params) { {ORG_DESC: 'Magesty'} }
    its(:department) { should eql 'Magesty' }
    it { expect(employee.attributes[:department]).to eql 'Magesty' }
  end

  describe '#title' do
    let(:params) { {TITLE: 'Burninator'} }
    its(:title) { should eql 'Burninator' }
    it { expect(employee.attributes[:title]).to eql 'Burninator' }
  end

  describe '#job_type' do
    let(:params) { {JOB_TYPE: 'Just a Dragon'} }
    its(:job_type) { should eql 'Just a Dragon' }
    it { expect(employee.attributes[:job_type]).to eql 'Just a Dragon' }
  end

  describe '#office_phone' do
    let(:params) { {DIR_EXT: '123-123-1234'} }
    its(:office_phone) { should eql '123-123-1234' }
    it { expect(employee.attributes[:office_phone]).to eql '123-123-1234' }
  end

  describe '#full_time' do
    context "when 'F'" do
      let(:params) { {FT_PT: 'F'} }
      its(:full_time) { should eql true }
      it { expect(employee.attributes[:full_time]).to eql true }
    end

    context "when other" do
      let(:params) { {FT_PT: 'X'} }
      its(:full_time) { should eql false }
      it { expect(employee.attributes[:full_time]).to eql false }
    end

    context 'when nil' do
      let(:params) { {FT_PT: nil} }
      its(:full_time) { should eql false }
      it { expect(employee.attributes[:full_time]).to eql false }
    end
  end
end