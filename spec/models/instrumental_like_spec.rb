require 'rails_helper'

describe InstrumentalLike do
  context "associations" do
    it { should belong_to(:instrumental).touch(true) }
    it { should belong_to(:user).touch(true) }
  end

  context "validations" do
    context "presence" do
      it { should validate_presence_of(:instrumental) }
      it { should validate_presence_of(:user) }
    end

    context "uniquness" do
      it do
        create(:instrumental_like)
        should validate_uniqueness_of(:instrumental).scoped_to(:user_id)
      end
    end
  end
end
