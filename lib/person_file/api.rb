module PersonFile
  require 'grape'

  class API < Grape::API

    desc "Add a person"
    params do
      requires :data, type: String, desc: "The person's information"
    end
    post '/records' do
      Database.new.write params[:data]
    end
  end
end