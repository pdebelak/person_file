module PersonFile
  describe Sorter do

    let(:sorter) { Sorter.new Database.new.read 'spec/fixtures/files/comma_separated_file' }

    describe '#by_gender' do

      it 'sorts by gender' do
        expect(sorter.by_gender.map { |x| x[:gender] }).to eq(['female', 'female', 'male', 'male', 'male'])
      end

      it 'sorts by last name ascending secondarily' do
        expect(sorter.by_gender.map { |x| x[:last_name] }).to eq(['Adams', 'Denesik', 'Daugherty', 'Johnston', 'Quigley'])
      end
    end

    describe '#by_birthday' do

      it 'sorts by date of birth ascending' do
        expect(sorter.by_birthday.map { |x| x[:date_of_birth] }).to eq(['08/04/2012', '03/25/2013', '07/20/2013', '10/20/2013', '06/26/2014'])
      end
    end

    describe '#by_last_name_descending' do

      it 'sorts by last name descending' do
        expect(sorter.by_last_name_descending.map { |x| x[:last_name] }).to eq(['Quigley', 'Johnston', 'Denesik', 'Daugherty', 'Adams'])
      end
    end
  end
end