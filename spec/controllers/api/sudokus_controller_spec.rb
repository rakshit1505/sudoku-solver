require 'rails_helper'

RSpec.describe Api::SudokusController, type: :request do
  describe "POST /api/sudoku" do
    context 'for invalid input' do

      context "when data size is invalid" do
        it 'should return error' do
          post '/api/sudoku', params: {'data': [ ]}
          res_body = JSON.parse(response.body)

          expect(response).to have_http_status 422
          expect(res_body["error"]).to eq('Array size should be 9X9')
        end

        it 'should return error' do
          post '/api/sudoku', params: {'data': [ [ ] ]}
          res_body = JSON.parse(response.body)

          expect(response).to have_http_status 422
          expect(res_body["error"]).to eq('Array size should be 9X9')
        end
      end

      context 'when data value is invalid' do
        context "when value is repeat" do
          it 'should return error' do
            post '/api/sudoku', params: {
              "data": [
                [2, nil, 5, nil, nil, 9, nil, 2, 4],
                [nil, nil, nil, nil, nil, nil, 3, nil, 7],
                [7, nil, nil, 8, 5, 6, nil, 1, nil],
                [4, 5, nil, 7, nil, nil, nil, nil, nil],
                [nil, nil, 9, nil, nil, nil, 1, nil, nil],
                [nil, nil, nil, nil, nil, 2, nil, 8, 5],
                [nil, 2, nil, 4, 1, 8, nil, nil, 6],
                [6, nil, 8, nil, nil, nil, nil, nil, nil],
                [1, nil, nil, 2, nil, nil, 7, nil, 8]
              ]
            }, as: :json
            res_body = JSON.parse(response.body)
    
            expect(response).to have_http_status 422
            expect(res_body["error"]).to eq("Can't solve sudoku")
          end
        end
        
        context "when value is greater than 9" do
          it 'should return error' do
            post '/api/sudoku', params: {
              "data": [
                [2, nil, 5, nil, nil, 9, nil, nil, 40],
                [nil, nil, nil, nil, nil, nil, 3, nil, 7],
                [7, nil, nil, 8, 5, 6, nil, 1, nil],
                [4, 5, nil, 7, nil, nil, nil, nil, nil],
                [nil, nil, 9, nil, nil, nil, 1, nil, nil],
                [nil, nil, nil, nil, nil, 2, nil, 8, 5],
                [nil, 2, nil, 4, 1, 8, nil, nil, 6],
                [6, nil, 8, nil, nil, nil, nil, nil, nil],
                [1, nil, nil, 2, nil, nil, 7, nil, 8]
              ]
            }, as: :json
            res_body = JSON.parse(response.body)
    
            expect(response).to have_http_status 422
            expect(res_body["error"]).to eq("Can't solve sudoku")
          end
        end

        context "when value is less than 1" do
          it 'should return error' do
            post '/api/sudoku', params: {
              "data": [
                [2, nil, 5, nil, nil, 9, nil, nil, 0],
                [nil, nil, nil, nil, nil, nil, 3, nil, 7],
                [7, nil, nil, 8, 5, 6, nil, 1, nil],
                [4, 5, nil, 7, nil, nil, nil, nil, nil],
                [nil, nil, 9, nil, nil, nil, 1, nil, nil],
                [nil, nil, nil, nil, nil, 2, nil, 8, 5],
                [nil, 2, nil, 4, 1, 8, nil, nil, 6],
                [6, nil, 8, nil, nil, nil, nil, nil, nil],
                [1, nil, nil, 2, nil, nil, 7, nil, 8]
              ]
            }, as: :json
            res_body = JSON.parse(response.body)
    
            expect(response).to have_http_status 422
            expect(res_body["error"]).to eq("Can't solve sudoku")
          end
        end
      end

      context 'when data is valid' do
        it 'should return success with status 200' do
          post '/api/sudoku', params: {
            "data": [
              [2, nil, 5, nil, nil, 9, nil, nil, 4],
              [nil, nil, nil, nil, nil, nil, 3, nil, 7],
              [7, nil, nil, 8, 5, 6, nil, 1, nil],
              [4, 5, nil, 7, nil, nil, nil, nil, nil],
              [nil, nil, 9, nil, nil, nil, 1, nil, nil],
              [nil, nil, nil, nil, nil, 2, nil, 8, 5],
              [nil, 2, nil, 4, 1, 8, nil, nil, 6],
              [6, nil, 8, nil, nil, nil, nil, nil, nil],
              [1, nil, nil, 2, nil, nil, 7, nil, 8]
            ]
          }, as: :json
          res_body = JSON.parse(response.body)
  
          expect(response).to have_http_status 200
        end
      end
    end
  end
end