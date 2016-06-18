require "./github-contributors/*"

module Contributors
  ENDPOINT = "https://api.github.com"

  extend Contributors::Response

  def self.run
    options = Contributors::CLI.new
    contributors = Contributors.get_repo_contributors(options.repository)
    puts contributors
  end
end
