module PersonFile
  class Parser

    def parse(entry)
      split(entry).each_with_index.map do |item, index|
        [KEYS[index], item]
      end.to_h
    end

    private

      KEYS = [:last_name, :first_name, :gender, :favorite_color, :date_of_birth]

      def split(entry)
        entry.split(separator entry)
      end

      def separator(entry)
        if entry =~ / \| /
          " | "
        elsif entry =~ /, /
          ", "
        end
      end
  end
end