require 'rails_helper'

describe "Api::V1::Instrumentals" do
  describe "#show" do
    context "when an instrumental is found" do
      it "returns a successful request" do
        VCR.use_cassette("deezer api returns an instrumental") do
          search = "zeze"

          get api_v1_instrumentals_path, params: { q: search }
          parsed_body = JSON.parse(response.body)
          first_instrumental_title = parsed_body["data"][0]["title"]

          expect(first_instrumental_title).to eq "Zeze (Instrumental)"
        end
      end
    end

    context "when an instrumental is not found" do
      it "returns an error" do
        VCR.use_cassette("deezer api returns an error") do
          search = "thisisarandomsearchterm"

          get api_v1_instrumentals_path, params: { q: search }
          parsed_body = JSON.parse(response.body)

          expect(parsed_body["status"]).to eq "404"
          expect(parsed_body["error"]).to eq "Instrumental Not Found"
        end
      end
    end
  end

  describe "#create" do
    context "when the params are valid" do
      it "adds a new instrumental to the database" do
        VCR.use_cassette("new instrumental record is saved") do
          params = { title: "Zeze (Instrumental)", track: "zeze.mp3" }

          post api_v1_instrumentals_path, params: { instrumental: params  }

          expect(Instrumental.count).to eq 1
        end
      end
    end

    context "when an instrumental is already persisted in the database" do
      it "does not save the record" do
        VCR.use_cassette("record is not saved when instrumental exists") do
          create(:instrumental, title: "Zeze (Instrumental)")
          params = { title: "ZeZe (instrumental)", track: "zeze.mp3" }

          post api_v1_instrumentals_path, params: { instrumental: params }

          expect(Instrumental.count).not_to eq 2
        end
      end
    end

    context "when the params are invalid" do
      it "returns an error" do
        VCR.use_cassette("returns an error for invalid params") do
          params = { title: "", track: "" }

          post api_v1_instrumentals_path, params: { instrumental: params }
          parsed_response = JSON.parse(response.body)

          expect(parsed_response["message"]).to eq("unprocessable entity")
        end
      end
    end
  end
end
