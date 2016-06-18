require "option_parser"

module Contributors
  class CLI
    def initialize
      @verbose = false
      parse
    end

    def parse
      OptionParser.parse! do |parser|
        parser.banner = "Usage: contributors [arguments]"
        parser.on("-h", "--help", "Show this help") { puts parser }
      end

      repository = ARGV.first?

      if !repository
        puts "Please provide a repository name like django/django"
        exit
      end

      if ENV["GITHUB_SECRET"]?.nil?
        puts "You must set a GITHUB_SECRET environment variable"
      end
    end
  end
end
