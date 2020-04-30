require "rails_helper"

describe "Api::V1::Instrumentals" do
  describe "#index" do
    it "returns all instrumental records" do
      create(:instrumental)
      create(:instrumental)

      get "/api/v1/instrumentals"

      expect(parsed_response.length).to eq 2
    end
  end

  describe "#show" do
    context "when an instrumental is found in database" do
      it "returns the correct record" do
        VCR.use_cassette("finds instrumental in database") do
          instrumental = create(:instrumental, title: "My song")

          get "/api/v1/instrumentals/#{instrumental.id}"

          expect(parsed_response["title"]).to eq "My song"
        end
      end
    end

    context "when an instrumental is found by search" do
      it "returns a successful request" do
        VCR.use_cassette("deezer api returns an instrumental") do
          search = "zeze"

          get "/api/v1/instrumentals/#{search}"

          first_instrumental_title = parsed_response["data"][0]["title"]
          expect(first_instrumental_title).to eq "Zeze (Instrumental)"
        end
      end
    end

    context "when an instrumental is not found" do
      it "returns an error" do
        VCR.use_cassette("deezer api returns an error") do
          search = "thisisarandomsearchterm"

          get "/api/v1/instrumentals/#{search}"

          expect(parsed_response["status"]).to eq "404"
          expect(parsed_response["error"]).to eq "Instrumental Not Found"
        end
      end
    end
  end

  describe "#create" do
    context "when the params are valid" do
      it "adds a new instrumental to the database" do
        VCR.use_cassette("new instrumental record is saved") do
          params = { title: "Zeze (Instrumental)", track: "zeze.mp3" }

          post "/api/v1/instrumentals", params: { instrumental: params  }

          expect(Instrumental.count).to eq 1
        end
      end
    end

    context "when an instrumental is already persisted in the database" do
      it "does not save the record" do
        VCR.use_cassette("record is not saved when instrumental exists") do
          create(:instrumental, title: "Zeze (Instrumental)")
          params = { title: "ZeZe (instrumental)", track: "zeze.mp3" }

          post "/api/v1/instrumentals", params: { instrumental: params }

          expect(Instrumental.count).not_to eq 2
        end
      end
    end

    context "when the params are invalid" do
      it "returns an error" do
        VCR.use_cassette("returns an error for invalid params") do
          params = { title: "", track: "" }

          post "/api/v1/instrumentals", params: { instrumental: params }

          expect(parsed_response["message"]).to eq("unprocessable entity")
        end
      end
    end
  end

  def parsed_response
    JSON.parse(response.body)
  end
end
