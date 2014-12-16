require 'spec_helper'

describe PersonSynchronizer do
  let(:affiliation) { :student }
  let(:old_attrs) { {} }
  let(:new_attrs) { {} }
  let(:old_person) { "Trogdir::#{affiliation.to_s.classify}".constantize.new(old_attrs) }
  let(:new_person) { "Banner::#{affiliation.to_s.classify}".constantize.new(new_attrs) }
  let(:person_change) { PersonChange.new(old_person, new_person) }

  subject { PersonSynchronizer.new(person_change, Affiliation.find(affiliation)) }

  before do
    %w{person id address email phone}.each do |m|
      subject.stub("#{m}_api").and_return({})
    end
  end

  context 'when creating a person' do
    let(:new_attrs) { {FNAME: 'John', LNAME: 'Doe'} }

    it 'calls person_api :create' do
      expect(subject).to receive(:person_api).with(:create, kind_of(Hash)).and_return { {uuid: '12345567890'} }
      subject.call
    end
  end

  context 'when user exists' do
    let(:old_attrs) { {first_name: 'John', last_name: 'Doe', affiliations: [Affiliation.find(affiliation)]}.merge more_old_attrs }
    let(:more_old_attrs) { {} }
    let(:new_attrs) { {FNAME: 'Johnny', LNAME: 'Doe'}.merge more_new_attrs }
    let(:more_new_attrs){ {} }

    context 'when updating a person' do
      it 'calls person_api :update' do
        expect(subject).to receive(:person_api).with(:update, kind_of(Hash))
        subject.call
      end
    end

    context 'when removing an affiliation' do
      let(:more_old_attrs) { {mailbox: '42', affiliations: [Affiliation.find('student'), Affiliation.find('employee')]} }
      let(:new_attrs) { {} }

      it 'calls person_api :update' do
        expect(subject).to receive(:person_api).with(:update, hash_including(affiliations: ['employee']))
        subject.call
      end

      it 'it removes attributes that no longer apply to their new affiliations' do
        expect(subject).to receive(:person_api).with(:update, hash_including(mailbox: nil))
        subject.call
      end

      context 'when removing all affiliations' do
        let(:more_old_attrs) { {affiliations: [Affiliation.find('student')]} }

        it "doesn't remove the global person attributes" do
          expect(subject).to receive(:person_api).with(:update, hash_excluding(first_name: nil))
          subject.call
        end
      end
    end

    context 'when creating an id' do
      let(:more_new_attrs) { {PIDM: '4242'} }

      it 'calls id_api :create' do
        expect(subject).to receive(:id_api).with(:create, kind_of(Hash))
        subject.call
      end
    end

    context 'when updating an id' do
      let(:more_old_attrs) { {ids: [{id: 123, type: 'biola_id', identifier: '42'}]} }
      let(:more_new_attrs) { {ID: '4242'} }

      it 'calls id_api :update' do
        expect(subject).to receive(:id_api).with(:update, kind_of(Hash))
        subject.call
      end
    end

    context 'when removing an id' do
      let(:more_old_attrs) { {ids: [{id: 123, type: 'biola_id', identifier: '42'}]} }
      let(:more_new_attrs) { {ID: nil} }

      it 'calls id_api :destroy' do
        expect(subject).to receive(:id_api).with(:destroy, kind_of(Hash))
        subject.call
      end
    end

    context 'when creating an address' do
      let(:more_new_attrs) { {CITY: 'Nowheresville'} }

      it 'calls address_api :create' do
        expect(subject).to receive(:address_api).with(:create, kind_of(Hash))
        subject.call
      end
    end

    context 'when updating an address' do
      let(:more_old_attrs) { {addresses: [{id: 123, type: 'home', city: 'Nowheresville'}]} }
      let(:more_new_attrs) { {CITY: 'Niltown'} }

      it 'calls address_api :update' do
        expect(subject).to receive(:address_api).with(:update, kind_of(Hash))
        subject.call
      end
    end

    context 'when removing an address' do
      let(:more_old_attrs) { {addresses: [{id: 123, type: 'home', city: 'Niltown'}]} }
      let(:more_new_attrs) { {CITY: nil} }

      it 'calls address_api :destroy' do
        expect(subject).to receive(:address_api).with(:destroy, kind_of(Hash))
        subject.call
      end
    end

    context 'when creating an email' do
      let(:more_new_attrs) { {EMAIL: 'john.doe@biola.edu'} }

      it 'calls email_api :create' do
        expect(subject).to receive(:email_api).with(:create, kind_of(Hash))
        subject.call
      end
    end

    context 'when updating an email' do
      let(:more_old_attrs) { {emails: [{id: 123, type: 'university', address: 'john.doe@biola.edu'}]} }
      let(:more_new_attrs) { {EMAIL: 'jonny.doe@biola.edu'} }

      it 'calls id_api :update' do
        expect(subject).to receive(:email_api).with(:update, kind_of(Hash))
        subject.call
      end
    end

    context 'when removing an email' do
      let(:more_old_attrs) { {emails: [{id: 123, type: 'university', address: 'john.doe@biola.edu'}]} }
      let(:more_new_attrs) { {EMAIL: nil} }

      it 'calls id_api :destroy' do
        expect(subject).to receive(:email_api).with(:destroy, kind_of(Hash))
        subject.call
      end
    end

    context 'with an employee affiliation' do
      let(:affiliation) { :employee }

      context 'when creating a phone' do
        let(:more_new_attrs) { {DIR_EXT: '42'} }

        it 'calls phone_api :create' do
          expect(subject).to receive(:phone_api).with(:create, kind_of(Hash))
          subject.call
        end
      end

      context 'with an existing phone' do
        let(:more_old_attrs) { {phones: [{id: 123, type: 'office', number: '042'}]} }

        context 'when updating a phone' do
          let(:more_new_attrs) { {DIR_EXT: '043'} }

          it 'calls id_api :update' do
            expect(subject).to receive(:phone_api).with(:update, kind_of(Hash))
            subject.call
          end
        end

        context 'when removing a phone' do
          let(:more_new_attrs) { {DIR_EXT: nil} }

          it 'calls id_api :destroy' do
            expect(subject).to receive(:phone_api).with(:destroy, kind_of(Hash))
            subject.call
          end
        end
      end
    end
  end
end
