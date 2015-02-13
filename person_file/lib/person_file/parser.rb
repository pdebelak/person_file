module PersonFile
  class Parser

    def parse(entry)
      return entry if parsed?(entry)
      split(entry).each_with_index.map do |item, index|
        [KEYS[index], item]
      end.to_h
    end

    private

      KEYS = [:last_name, :first_name, :gender, :favorite_color, :date_of_birth]

      def split(entry)
        split = entry.split(separator entry)
        raise ArgumentError unless split.count == KEYS.count
        split
      end

      def separator(entry)
        if entry =~ / \| /
          " | "
        elsif entry =~ /, /
          ", "
        end
      end

      def parsed?(entry)
        entry.is_a?(Hash) && entry.keys.sort == KEYS.sort
      end
  end
end