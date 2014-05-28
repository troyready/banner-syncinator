require 'spec_helper'

[Trogdir::Employee, Trogdir::Volunteer].each do |klass|
  describe klass do
    let(:params) { {} }
    subject { klass.new(params) }

    describe '#pay_type' do
      let(:params) { {pay_type: '02'} }
      its(:pay_type) { should eql '02' }
    end

    describe '#department' do
      let(:params) { {department: 'Magesty'} }
      its(:department) { should eql 'Magesty' }
    end

    describe '#title' do
      let(:params) { {title: 'Burninator'} }
      its(:title) { should eql 'Burninator' }
    end

    describe '#job_type' do
      let(:params) { {job_type: 'Just a Dragon'} }
      its(:job_type) { should eql 'Just a Dragon' }
    end

    describe '#office_phone' do
      let(:params) { {phones: [{type: 'office', number: '123-123-1234'}]} }
      its(:office_phone) { should eql '123-123-1234' }
    end

    describe '#office_phone_id' do
      let(:params) { {phones: [{type: 'office', id: 12}]} }
      its(:office_phone_id) { should eql 12 }
    end

    describe '#full_time' do
      let(:params) { {full_time: true} }
      its(:full_time) { should eql true }
    end
  end
end