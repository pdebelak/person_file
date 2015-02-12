module PersonFileParser
  class Parser

    def initialize(file)
      @file = file
    end

    def parse
      parsed_file = []
      File.open(file, "r") do |f|
        f.each_line do |line|
          parsed_file << separated(line)
        end
      end
      parsed_file
    end

    private

      attr_reader :file

      KEYS = [:last_name, :first_name, :gender, :favorite_color, :date_of_birth]

      def separated(line)
        separated = {}
        line.split(separator).each_with_index do |item, index|
          separated[KEYS[index]] = item
        end
        parse_date_of_birth separated
      end

      def separator
        @separator ||= determine_separator
      end

      def parse_date_of_birth(parsed_line)
        parsed_line[:date_of_birth] = Date.strptime(parsed_line[:date_of_birth], "%m/%d/%Y")
        parsed_line
      end

      def determine_separator
        first_line = File.open(file, &:readline)
        if first_line =~ / \| /
          " | "
        elsif first_line =~ /, /
          ", "
        end
      end
  end
end