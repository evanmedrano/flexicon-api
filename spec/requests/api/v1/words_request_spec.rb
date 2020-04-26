require 'rails_helper'

describe "Api::V1::Words" do
  context "when the request is successful" do
    it "returns a random word" do
      VCR.use_cassette("returns a random word", :match_requests_on => [:headers]) do
      end
    end
  end

end
