require 'rails_helper'

describe User do
  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:github_id) }
    it { should validate_presence_of(:github_login) }
  end
end
