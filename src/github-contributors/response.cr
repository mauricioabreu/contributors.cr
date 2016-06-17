require "http/client"
require "json"

module Contributors
  module Response
		PER_PAGE = 100

    def get(path : String)
      uri = "#{ENDPOINT}/#{path}"
      response = HTTP::Client.get(
        uri, headers: HTTP::Headers{"Authorization": "token #{ENV["GITHUB_SECRET"]}"}
      )
      response
    end

    def get_repo_contributors(repository : String)
      contributors = paginate("repos/#{repository}/contributors")
      result = [] of String
      contributors.each do |contributor|
        result << contributor["login"].as_s
      end
			result.sort
    end

		def paginate(path : String, page = 1, result = [] of JSON::Any)
      response = get(path + "?page=#{page}&per_page=#{PER_PAGE}")
      result.concat(JSON.parse(response.body))
			link = response.headers.fetch("Link", "")
			if link.includes?("rel=\"next\"")
        page = page + 1
        paginate(path, page, result)
      end
      result
    end
  end
end
