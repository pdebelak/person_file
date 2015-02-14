require_relative '../spec_helper'

module PersonFile
  describe CommandLineInterface do

    describe '#initialize' do

      let(:cli) { CommandLineInterface.new ['create', 'filename', 'other_filename'] }

      before(:each) do
        allow_any_instance_of(Database).to receive(:create).and_return(nil)
      end

      it 'sets first element in array to @command' do
        expect(cli.instance_variable_get(:@command)).to eq('create')
      end

      it 'sets all other elements to @arguments' do
        expect(cli.instance_variable_get(:@arguments)).to eq(['filename', 'other_filename'])
      end
    end
    
    describe '#create' do

      it 'calls create on the database with the input files' do
        expect_any_instance_of(Database).to receive(:create).with 'filename', 'other_filename'
        CommandLineInterface.new ['create', 'filename', 'other_filename']
      end
    end

    describe 'read sorted output methods' do

      before(:each) do
        allow_any_instance_of(Database).to receive(:read).and_return(
          [{ last_name: 'Debelak', 
             first_name: 'Peter', 
             gender: 'male', 
             favorite_color: 'orange', 
             date_of_birth: '03/20/1985' },
           { last_name: 'Hanson', 
             first_name: 'Alana', 
             gender: 'female', 
             favorite_color: 'brown', 
             date_of_birth: '02/22/1984' }])
      end

      describe '#sort_by_gender' do

        it 'outputs appropriately sorted data' do
          expect{ CommandLineInterface.new ['sort_by_gender'] }.to output(
            "last_name\tfirst_name\tgender\tfavorite_color\tdate_of_birth
Hanson\tAlana\tfemale\tbrown\t02/22/1984
Debelak\tPeter\tmale\torange\t03/20/1985\n"
          ).to_stdout
        end
      end

      describe '#sort_by_birthday' do
        it 'outputs appropriately sorted data' do
          expect{ CommandLineInterface.new ['sort_by_birthday'] }.to output(
            "last_name\tfirst_name\tgender\tfavorite_color\tdate_of_birth
Hanson\tAlana\tfemale\tbrown\t02/22/1984
Debelak\tPeter\tmale\torange\t03/20/1985\n"
          ).to_stdout
        end
      end

      describe '#sort_by_last_name_descending' do
        it 'outputs appropriately sorted data' do
          expect{ CommandLineInterface.new ['sort_by_last_name_descending'] }.to output(
            "last_name\tfirst_name\tgender\tfavorite_color\tdate_of_birth
Hanson\tAlana\tfemale\tbrown\t02/22/1984
Debelak\tPeter\tmale\torange\t03/20/1985\n"
          ).to_stdout
        end
      end
    end

    describe '#help' do

      it 'outputs the help message to commands it doesn\'t understand' do
        expect{ CommandLineInterface.new ['halp', 'create'] }.to output("You need help!\n").to_stdout
      end
    end
  end
end