require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  before do
    create :user
  end

  describe "#create" do
    context 'valid' do
      before do
        post '/api/v1/session', params: {email: 'user@mail.app', password: 'valid_password'}
      end

      it 'success' do
        expect(response).to have_http_status(:success)
      end

      it 'has token' do
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'invalid' do
      before do
        post '/api/v1/session', params: {email: 'user@mail.app', password: 'wrong_password'}
      end

      it 'success' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
