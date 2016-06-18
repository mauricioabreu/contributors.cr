require "./github-contributors/*"

module Contributors
  ENDPOINT = "https://api.github.com"

  extend Contributors::Response

  def self.run
    options = Contributors::CLI.new
    repo_contributors = Contributors.get_repo_contributors(options.repository)
    issue_contributors = Contributors.get_issue_contributors(options.repository)
  end
end
