require "./github-contributors/*"

module Contributors
  ENDPOINT = "https://api.github.com"

  extend Contributors::Response
end
