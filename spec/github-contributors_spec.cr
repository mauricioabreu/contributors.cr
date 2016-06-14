require "./spec_helper"

ENV["GITHUB_SECRET"] = "dummy_token"

describe Contributors do
  context "when requesting contributors from repos resource" do
    subject(contributors) { Contributors.get_repo_contributors("django/django") }
    let(json) { Fixture.load("contributors.json") }

    it "returns a list of contributors" do
      WebMock.wrap do
        WebMock.stub(:get, "api.github.com/repos/django/django/contributors").to_return(json)
        expect(contributors.size).to eq(2)
        expect(contributors[0]).to eq("adrianholovaty")
        expect(contributors[1]).to eq("timgraham")
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
  end
end
