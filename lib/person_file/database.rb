module PersonFile
  class Database

    def initialize(database_file='database_file')
      @parser = Parser.new
      @database_file = database_file
    end

    def read(file=database_file)
      parsed_file = []
      File.foreach(file) do |line|
        parsed_file << parser.parse(line.chomp)
      end
      parsed_file
    end

    def write(data)
      File.open(database_file, 'a') { |f| f.puts normalize(data) }
    end

    def create(*files)
      files.each do |file|
        File.foreach(file) do |line|
          write(line)
        end
      end
    end

    private

      attr_reader :parser, :database_file

      def normalize(data)
        parser.parse(data).values.join(' ')
      end
  end
end