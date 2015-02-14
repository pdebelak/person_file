module PersonFile
  require 'grape'

  class API < Grape::API

    format :json

    namespace :records do

      desc "Add a person"
      params do
        requires :data, type: String, desc: "The person's information"
      end
      post do
        Database.new.write params[:data]
      end

      desc "Get records sorted by gender then last name ascending"
      get '/gender' do
        Sorter.new.by_gender
      end

      desc "Get records sorted by birth date"
      get '/birthdate' do
        Sorter.new.by_birthday
      end

      desc "Get records sorted by last name descending"
      get '/name' do
        Sorter.new.by_last_name_descending
      end
    end
  end
end