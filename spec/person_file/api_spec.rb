require_relative '../spec_helper'
require 'rack/test'

module PersonFile
  describe API do
    include Rack::Test::Methods

    def app
      PersonFile::API
    end

    describe 'post /records' do

      around(:each) do |example|
        # clean up the database file
        File.open('database_file', 'w') {}
        example.run
        File.open('database_file', 'w') {}
      end

      it 'responds to the route' do
        post '/records', data: 'Debelak Peter male orange 03/20/1985'
        expect(last_response.status).to eq 201
      end

      it 'adds a record to database file' do
        post '/records', data: 'Debelak Peter male orange 03/20/1985'
        expect(File.read('database_file')).to eq("Debelak Peter male orange 03/20/1985\n")
      end
    end

    describe 'get routes' do

      before(:each) do
        allow_any_instance_of(Database).to receive(:read).and_return(
          [{ last_name: 'Debelak', 
             first_name: 'Peter', 
             gender: 'male', 
             favorite_color: 'orange', 
             date_of_birth: '03/20/1983' },
           { last_name: 'Hanson', 
             first_name: 'Alana', 
             gender: 'female', 
             favorite_color: 'brown', 
             date_of_birth: '02/22/1984' }])
      end

      describe '/records/gender' do

        it 'responds to the route' do
          get '/records/gender'
          expect(last_response.status).to eq 200
        end

        it 'returns properly sorted json' do
          get '/records/gender'
          expect(last_response.body).to eq '[{"last_name":"Hanson","first_name":"Alana","gender":"female","favorite_color":"brown","date_of_birth":"02/22/1984"},{"last_name":"Debelak","first_name":"Peter","gender":"male","favorite_color":"orange","date_of_birth":"03/20/1983"}]'
        end
      end


      describe '/records/birthdate' do

        it 'responds to the route' do
          get '/records/birthdate'
          expect(last_response.status).to eq 200
        end

        it 'returns properly sorted json' do
          get '/records/birthdate'
          expect(last_response.body).to eq '[{"last_name":"Debelak","first_name":"Peter","gender":"male","favorite_color":"orange","date_of_birth":"03/20/1983"},{"last_name":"Hanson","first_name":"Alana","gender":"female","favorite_color":"brown","date_of_birth":"02/22/1984"}]'
        end
      end
      
      describe '/records/name' do

        it 'responds to the route' do
          get '/records/name'
          expect(last_response.status).to eq 200
        end

        it 'returns properly sorted json' do
          get '/records/name'
          expect(last_response.body).to eq '[{"last_name":"Hanson","first_name":"Alana","gender":"female","favorite_color":"brown","date_of_birth":"02/22/1984"},{"last_name":"Debelak","first_name":"Peter","gender":"male","favorite_color":"orange","date_of_birth":"03/20/1983"}]'
        end
      end
    end
  end
end