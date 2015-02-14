module PersonFile
  describe Sorter do

    let(:sorter) { Sorter.new }

    before(:each) do
      allow_any_instance_of(Database).to receive(:read).and_return(
        [{ last_name: 'Quigley', 
           first_name: 'Alexandro', 
           gender: 'male', 
           favorite_color: 'red', 
           date_of_birth: '08/04/2012' },
         { last_name: 'Denesik', 
           first_name: 'Queen', 
           gender: 'female', 
           favorite_color: 'orange', 
           date_of_birth: '03/25/2013' },
         { last_name: 'Johnston', 
           first_name: 'Collin', 
           gender: 'male', 
           favorite_color: 'yellow', 
           date_of_birth: '06/26/2014' },
         { last_name: 'Daugherty', 
           first_name: 'Frederic', 
           gender: 'male', 
           favorite_color: 'green', 
           date_of_birth: '07/20/2013' },
         { last_name: 'Adams', 
           first_name: 'Missouri', 
           gender: 'female', 
           favorite_color: 'blue', 
           date_of_birth: '10/20/2013' }])
    end

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