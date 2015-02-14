require_relative '../spec_helper'

module PersonFile
  describe Database do
    let (:db) { Database.new 'spec/fixtures/files/spec_database' }

    describe '#initialize' do

      it 'sets the @database_file to the input' do
        expect(db.instance_variable_get(:@database_file)).to eq('spec/fixtures/files/spec_database')
      end
    end
    
    describe '#read' do

      before(:all) do
        @pipe_separated_file_parsed = [ 
            { last_name: 'Debelak', 
              first_name: 'Peter', 
              gender: 'male', 
              favorite_color: 'orange', 
              date_of_birth: '03/20/1985' },
            { last_name: 'Hanson', 
              first_name: 'Alana', 
              gender: 'female', 
              favorite_color: 'brown', 
              date_of_birth: '02/22/1984'} ]
      end

      it 'reads an input file into an array of parsed hashes' do
        expect(db.read('spec/fixtures/files/pipe_separated_file')).to eq @pipe_separated_file_parsed
      end

      it 'reads the database file by default' do
        allow(db).to receive(:database_file).and_return 'spec/fixtures/files/pipe_separated_file'
        expect(db.read).to eq @pipe_separated_file_parsed
      end
    end

    describe '#write' do

      after(:each) do
        # clean up the database file
        File.open('spec/fixtures/files/spec_database', 'w') {}
      end

      context 'with properly formatted input' do

        it 'should write to the database file' do
          db.write('Debelak Peter male orange 03/20/1985')
          expect(File.read('spec/fixtures/files/spec_database')).to eq("Debelak Peter male orange 03/20/1985\n")
        end

        it 'should append to the file' do
          File.open('spec/fixtures/files/spec_database', 'w') { |f| f.puts 'Debelak Peter male orange 03/20/1985' }
          db.write('Hanson Alana female brown 02/22/1984')
          expect(File.read('spec/fixtures/files/spec_database'))
            .to eq("Debelak Peter male orange 03/20/1985\nHanson Alana female brown 02/22/1984\n")
        end
      end

      context 'with improperly formatted input' do

        it 'does not write and raises error' do
          expect{ db.write("Debelak Peter male orange") }.to raise_error ArgumentError
          expect(File.read('spec/fixtures/files/spec_database')).to eq('')
        end
      end
    end

    describe '#create' do

      after(:each) do
        # clean up the database file
        File.open('spec/fixtures/files/spec_database', 'w') {}
      end

      it 'adds contents of input file to database_file' do
        db.create('spec/fixtures/files/space_separated_file')
        expect(File.read('spec/fixtures/files/spec_database'))
            .to eq("Debelak Peter male orange 03/20/1985\nHanson Alana female brown 02/22/1984\n")
      end

      it 'stores data as space separated' do
        db.create('spec/fixtures/files/pipe_separated_file')
        expect(File.read('spec/fixtures/files/spec_database'))
            .to eq("Debelak Peter male orange 03/20/1985\nHanson Alana female brown 02/22/1984\n")
      end

      it 'handles multiple files' do
        db.create('spec/fixtures/files/space_separated_file', 'spec/fixtures/files/pipe_separated_file')
        expect(File.read('spec/fixtures/files/spec_database'))
            .to eq("Debelak Peter male orange 03/20/1985\nHanson Alana female brown 02/22/1984\nDebelak Peter male orange 03/20/1985\nHanson Alana female brown 02/22/1984\n")
      end
    end
  end
end