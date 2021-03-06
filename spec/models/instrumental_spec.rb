require 'rails_helper'

describe Instrumental do
  context "associations" do
    it { should have_many(:instrumental_likes) }
    it { should have_many(:user_likes).through(:instrumental_likes) }
  end

  context "validations" do
    context "presence" do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:track) }
    end

    context "uniqueness" do
      it { should validate_uniqueness_of(:title).case_insensitive }
    end
  end
end
