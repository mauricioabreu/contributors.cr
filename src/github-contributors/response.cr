require "http/client"
require "json"

module Contributors
  module Response
    def get(path : String)
      uri = "#{ENDPOINT}/#{path}"
      response = HTTP::Client.get(
        uri, headers: HTTP::Headers{"Authorization": "token #{ENV["GITHUB_SECRET"]}"}
      )
      response
    end

    def get_repo_contributors(repository : String)
      response = get("repos/#{repository}/contributors")
      result = [] of String
      contributors = JSON.parse(response.body)
      contributors.each do |contributor|
        result << contributor["login"].as_s
      end
      result
    end
  end
end
