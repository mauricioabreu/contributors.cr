module Contributors
  module Report
    def generate(contributors, file)
      puts "Writing all the awesome contributors in #{file}"
      File.open(file, "w") do |f|
        contributors.each{ |contributor| f.puts(contributor) }
      end
      puts "Done!"
    end
  end
end
