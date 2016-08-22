require 'rails_helper'

RSpec.describe UserExport do
  describe '#export_csv' do
    context 'for a user not in SAM yet' do
      xit 'should return the correct CSV' do
        user = FactoryGirl.create(:user)

        export = UserExport.new.export_csv

        parsed = CSV.parse(export)

        expect(parsed[1][0]).to include(user.name)
        expect(parsed[1][1]).to include(user.email)
        expect(parsed[1][2]).to include(user.github_id)
        expect(parsed[1][3]).to include('No')
        expect(parsed[1][4]).to include('N/A')
      end
    end

    context 'for an administrator user' do
      it 'should return no infomration' do
        FactoryGirl.create(:admin_user)

        export = UserExport.new.export_csv

        parsed = CSV.parse(export)

        expect(parsed[1]).to be_nil
      end
    end
  end
end
