require 'rails_helper'

describe User do
  context "validations" do
    context "presence" do
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
    end

    context "uniqueness" do
      it { should validate_uniqueness_of(:email).case_insensitive }
      it { should validate_uniqueness_of(:username).case_insensitive }
    end
  end
end
