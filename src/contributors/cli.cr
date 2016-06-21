require "option_parser"

module Contributors
  class CLI
    getter file, repository

    def initialize
      @file = "contributors.txt"
      @repository = ARGV.first? || ""
      parse
    end

    def parse
      OptionParser.parse! do |parser|
        parser.banner = "Usage: contributors [arguments]"
        parser.on("-f FILE", "--file FILE", "Output file name") do |file|
          @file = file
        end
        parser.on("-h", "--help", "Show this help") do
          puts parser
          exit 0
        end
      end

      if @repository.empty?
        puts "Please provide a repository name like django/django"
        exit
      end

      if ENV["GITHUB_SECRET"]?.nil?
        puts "You must set a GITHUB_SECRET environment variable"
				exit
      end
    end
  end
end
