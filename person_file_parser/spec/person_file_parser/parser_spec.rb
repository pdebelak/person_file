require_relative '../spec_helper'

module PersonFileParser
  describe Parser do

    describe '#parse' do

      let(:parser) { Parser.new }

      context 'with a pipe separated string' do

        it 'returns an organized hash' do
          expect(parser.parse 'Debelak | Peter | male | orange | 03/20/1985')
            .to eq({ last_name: 'Debelak', 
                     first_name: 'Peter', 
                     gender: 'male', 
                     favorite_color: 'orange', 
                     date_of_birth: '03/20/1985' })
        end
      end

      context 'with a comma separated string' do

        it 'returns an organized hash' do
          expect(parser.parse 'Debelak, Peter, male, orange, 03/20/1985')
            .to eq({ last_name: 'Debelak', 
                     first_name: 'Peter', 
                     gender: 'male', 
                     favorite_color: 'orange', 
                     date_of_birth: '03/20/1985' })
        end
      end

      context 'with a space separated string' do

        it 'returns an organized hash' do
          expect(parser.parse 'Debelak Peter male orange 03/20/1985')
            .to eq({ last_name: 'Debelak', 
                     first_name: 'Peter', 
                     gender: 'male', 
                     favorite_color: 'orange', 
                     date_of_birth: '03/20/1985' })
        end
      end
    end
  end
end