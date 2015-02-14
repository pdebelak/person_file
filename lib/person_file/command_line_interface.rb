module PersonFile
  class CommandLineInterface

    def initialize(args)
      @command = args[0]
      @arguments = args[1..-1]
      run_command
    end

    def create
      Database.new.create *arguments
    end

    def sort_by_gender
      display Sorter.new.by_gender
    end

    def sort_by_birthday
      display Sorter.new.by_birthday
    end

    def sort_by_last_name_descending
      display Sorter.new.by_last_name_descending
    end

    def help
      puts "You need help!"
    end

    private

      ALLOWED_COMMANDS = ['create', 'sort_by_gender', 'sort_by_birthday', 'sort_by_last_name_descending']

      attr_reader :command, :arguments

      def run_command
        if ALLOWED_COMMANDS.include? command
          self.send command.to_sym
        else
          help
        end
      end

      def display(data)
        puts data[0].keys.join("\t")
        data.each do |datum|
          puts datum.values.join("\t")
        end
      end
  end
end