require "./contributors/*"

module Contributors
  ENDPOINT = "https://api.github.com"

  extend Contributors::Report
  extend Contributors::Response

  def self.contributors(repository : String)
    puts "Fetching all contributors of #{repository}. It may take a while..."
    begin
      repo_contributors = Contributors.get_repo_contributors(repository)
      issue_contributors = Contributors.get_issue_contributors(repository)
    rescue ex
      puts ex.message
      exit 0
    end
    repo_contributors & issue_contributors
  end

  def self.run
    options = Contributors::CLI.new
    contributors = Contributors.contributors(options.repository)
    Contributors.generate(contributors, options.file)
  end
end
