require 'spec_helper'

describe Banner::Employee do
  let(:params) { {} }
  subject { Banner::Employee.new(params) }

  describe '#pay_type' do
    let(:params) { {PAYID: '02'} }
    its(:pay_type) { should eql '02' }
  end

  describe '#department' do
    let(:params) { {ORG_DESC: 'Magesty'} }
    its(:department) { should eql 'Magesty' }
  end

  describe '#title' do
    let(:params) { {TITLE: 'Burninator'} }
    its(:title) { should eql 'Burninator' }
  end

  describe '#job_type' do
    let(:params) { {JOB_TYPE: 'Just a Dragon'} }
    its(:job_type) { should eql 'Just a Dragon' }
  end

  describe '#office_phone' do
    let(:params) { {DIR_EXT: '123-123-1234'} }
    its(:office_phone) { should eql '123-123-1234' }
  end

  describe '#full_time' do
    context "when 'F'" do
      let(:params) { {FT_PT: 'F'} }
      its(:full_time) { should eql true }
    end

    context "when other" do
      let(:params) { {FT_PT: 'X'} }
      its(:full_time) { should eql false }
    end

    context 'when nil' do
      let(:params) { {FT_PT: nil} }
      its(:full_time) { should eql false }
    end
  end
end