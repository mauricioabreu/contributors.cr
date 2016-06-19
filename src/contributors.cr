require "./github-contributors/*"

module Contributors
  ENDPOINT = "https://api.github.com"

  extend Contributors::Response

  def self.contributors(repository : String)
    repo_contributors = Contributors.get_repo_contributors(repository)
    issue_contributors = Contributors.get_issue_contributors(repository)
    repo_contributors & issue_contributors
  end

  def self.run
    options = Contributors::CLI.new
    contributors = Contributors.contributors(options.repository)
    File.open("contributors.txt", "w") do |f|
      contributors.each{ |contributor| f.puts(contributor) }
    end
  end
end
