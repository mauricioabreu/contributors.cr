require "./spec_helper"

ENV["GITHUB_SECRET"] = "dummy_token"

describe Contributors do
  context "when requesting contributors from repos resource" do
    subject(contributors) { Contributors.get_repo_contributors("django/django") }
    let(json) { Fixture.load("contributors.json") }

    it "returns a list of contributors" do
      WebMock.wrap do
        WebMock.stub(:get, "api.github.com/repos/django/django/contributors?page=1&per_page=100").
          to_return(json)
        expect(contributors.size).to eq(2)
        expect(contributors[0]).to eq("adrianholovaty")
        expect(contributors[1]).to eq("timgraham")
      end
    end
  end

  context "when reading a paginated resource" do
    subject(response) { Contributors.paginate(Contributors::Response::Resource.new("foo/bar")) }
    let(foo_json) { Fixture.load("page_1.json") }
    let(bar_json) { Fixture.load("page_2.json") }

    it "returns all records of every response" do
      WebMock.wrap do
        WebMock.stub(:get, "api.github.com/foo/bar?page=1&per_page=100").
          to_return(foo_json, headers: {"Link" => "<https://api.github.com/foo/bar?page=2&per_page=100>; rel=\"next\""})
        WebMock.stub(:get, "api.github.com/foo/bar?page=2&per_page=100").to_return(bar_json)
        expect(response.size).to eq(2)
      end
    end
  end

  context "when requesting a JSON response" do
    subject(response) { Contributors.get("foo/bar") }
    let(json) { Fixture.load("dummy.json") }

    it "returns a JSON body" do
      WebMock.wrap do
        WebMock.stub(:get, "api.github.com/foo/bar").to_return(body: json)
        expect(response.body).to be_a(String)
      end
    end

    it "raises an exception if response was not succesful" do
      WebMock.wrap do
        WebMock.stub(:get, "api.github.com/foo/bar").to_return(status: 404)
        expect { response }.to raise_error(Contributors::Exceptions::UnsuccessfulResponse)
      end
    end
  end
end
