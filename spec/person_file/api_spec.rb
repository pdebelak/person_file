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

  end
end