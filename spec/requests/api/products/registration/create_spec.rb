require 'rails_helper'

RSpec.describe 'POST /api/registration', type: :request do
  describe 'POST /api/registration' do
    subject(:perform_request) { post '/api/registration', params: params, headers: headers }

    let(:headers) { { 'Content-Type': 'application/json' } }
    let(:params) do
      {
        user: {
          username: username,
          password: password
        }
      }.to_json
    end
    let(:username) { 'some_user_name' }
    let(:password) { '12345' }

    context 'username is NOT given' do
      let(:username) { nil }
      let(:expected_response) do
        {
          error: {
            username: ["can't be blank"]
          }
        }.to_json
      end

      it 'returns errors' do
        expect { perform_request }.not_to change(User, :count)

        expect(response).to have_http_status :bad_request
        expect(response.body).to eq expected_response
      end
    end

    context 'password is NOT given' do
      let(:password) { nil }
      let(:expected_response) do
        {
          error: {
            password: ["can't be blank"]
          }
        }.to_json
      end

      it 'returns errors' do
        expect { perform_request }.not_to change(User, :count)

        expect(response).to have_http_status :bad_request
        expect(response.body).to eq expected_response
      end
    end

    context 'valid params are given' do
      let(:expected_response) do
        {
          token: 'valid_token'
        }.to_json
      end

      before do
        allow(JWT).to receive(:encode).with(anything, anything) { 'valid_token' }
      end

      it 'returns a token' do
        expect { perform_request }.to change(User, :count).by(1)

        expect(response).to have_http_status :created
        expect(response.body).to eq expected_response
      end
    end
  end
end