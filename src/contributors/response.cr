require "http/client"
require "json"

module Contributors
  module Response
		PER_PAGE = 100

    def get(path : String)
      uri = "#{ENDPOINT}/#{path}"
      response = HTTP::Client.get(
        uri, headers: HTTP::Headers{"Authorization" => "token #{ENV["GITHUB_SECRET"]}"}
      )

      unless response.success?
        raise Exceptions::UnsuccessfulResponse.new("Something went wrong when requesting the URL")
      end

      response
    end

    def get_repo_contributors(repository : String)
      contributors = paginate(Resource.new("repos/#{repository}/contributors"))
      result = [] of String
      contributors.each do |contributor|
        result << contributor["login"].as_s
      end
			result.sort
    end

    def get_issue_contributors(repository : String)
      contributors = paginate(Resource.new("repos/#{repository}/issues", "state=all"))
      result = [] of String
      contributors.each do |contributor|
        result << contributor["user"]["login"].as_s
      end
      result.uniq.sort
    end

		def paginate(resource, page = 1, result = [] of JSON::Any)
      path = resource.path + "?page=#{page}&per_page=#{PER_PAGE}"
      if !resource.query.empty?
        path = "#{path}&#{resource.query}"
      end
      response = get(path)
      result.concat(JSON.parse(response.body))
			link = response.headers.fetch("Link", "")
			if link.includes?("rel=\"next\"")
        page = page + 1
        paginate(resource, page, result)
      end
      result
    end

    class Resource
      getter path, query

      def initialize(path : String, query = "")
        @path = path
        @query = query
      end
    end
  end
end
