require_relative '../spec_helper'

module PersonFileParser
  describe Parser do

    describe '#initialize' do

      it 'takes one argument' do
        expect(Parser.new 'a file').to be_an_instance_of PersonFileParser::Parser
      end

      it 'raises an error with no arguments' do
        expect{ Parser.new }.to raise_error ArgumentError
      end
    end

    describe '#parse' do

      context 'with a pipe separated file' do
        let(:parser) { Parser.new 'spec/fixtures/files/pipe_separated_file' }

        it 'returns an array' do
          expect(parser.parse).to be_an_instance_of Array
        end

        it 'creates a hash for each line' do
          expect(parser.parse.first).to eq({ last_name: 'Debelak', 
                                             first_name: 'Peter', 
                                             gender: 'male', 
                                             favorite_color: 'orange', 
                                             date_of_birth: '03/20/1985' })
        end
      end

      context 'with a comma separated file' do
        let(:parser) { Parser.new 'spec/fixtures/files/comma_separated_file' }

        it 'creates a hash for each line' do
          expect(parser.parse.first).to eq({ last_name: 'Debelak', 
                                             first_name: 'Peter', 
                                             gender: 'male', 
                                             favorite_color: 'orange', 
                                             date_of_birth: '03/20/1985' })
        end
      end

      context 'with a space separated file' do
        let(:parser) { Parser.new 'spec/fixtures/files/space_separated_file' }

        it 'creates a hash for each line' do
          expect(parser.parse.first).to eq({ last_name: 'Debelak', 
                                             first_name: 'Peter', 
                                             gender: 'male', 
                                             favorite_color: 'orange', 
                                             date_of_birth: '03/20/1985' })
        end
      end
    end
  end
end