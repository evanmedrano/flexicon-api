require 'rails_helper'

describe 'Api::V1::InstrumentalLikes' do
  describe '#index' do
    context 'as a registered user' do
      it 'returns all liked instrumentals' do
        user = create(:user)
        create(:instrumental_like, user: user)
        create(:instrumental_like, user: user)

        get '/api/v1/instrumental_likes', headers: authorize(user)

        expect(parsed_response.length).to eq 2
      end
    end

    context 'as a guest' do
      it 'returns a 401 status code' do
        get '/api/v1/instrumental_likes'

        expect(response).to have_http_status(401)
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'returns a new instrumental like' do
        user = create(:user)
        instrumental = create(:instrumental)
        params = {
          instrumental_like: {
            instrumental_id: instrumental.id, user_id: user.id
          }
        }
          .to_json

        post '/api/v1/instrumental_likes',
             params: params, headers: authorize(user)

        expect(InstrumentalLike.count).to eq 1
        expect(InstrumentalLike.first.user).to eq user
        expect(InstrumentalLike.first.instrumental).to eq instrumental
      end
    end

    context 'with invalid params' do
      it 'returns a 422 status code' do
        user = create(:user)
        params = { instrumental_like: { instrumental_id: nil, user_id: nil } }
          .to_json

        post '/api/v1/instrumental_likes',
             params: params, headers: authorize(user)

        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#destroy' do
    it 'returns one less liked instrumental for the user' do
      user = create(:user)
      instrumental_like = create(:instrumental_like, user: user)

      delete "/api/v1/instrumental_likes/#{instrumental_like.id}",
             headers: authorize(user)

      expect(user.liked_instrumentals.count).to eq 0
    end
  end

  def parsed_response
    JSON.parse(response.body)
  end
end
