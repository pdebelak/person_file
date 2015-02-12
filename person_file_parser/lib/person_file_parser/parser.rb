module PersonFileParser
  class Parser

    def initialize(file)
      @file = file
    end

    def parse
      parsed_file = []
      File.open(file, "r") do |f|
        f.each_line do |line|
          parsed_file << separated(line.chomp)
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
        separated
      end

      def separator
        @separator ||= determine_separator
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