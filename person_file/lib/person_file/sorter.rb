module PersonFile
  class Sorter

    def initialize(data)
      @data = data
    end

    def by_gender
      data.sort_by { |entry| [entry[:gender], entry[:last_name]] }
    end

    def by_birthday
      data.sort_by { |entry| Date.strptime(entry[:date_of_birth], '%m/%d/%Y') }
    end

    def by_last_name_descending
      data.sort_by { |entry| entry[:last_name] }.reverse
    end

    private

      attr_reader :data
  end
end