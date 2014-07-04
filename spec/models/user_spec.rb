# user_spec.rb

require 'spec_helper'

describe "user" do

  describe "roles" do

    it "assigns a default rater role" do
    	user = FactoryGirl.create :user
      expect(user.roles.count).to eq(1)
    end
  end
end