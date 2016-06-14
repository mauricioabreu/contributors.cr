module Fixture
  def self.load(path)
    File.read(File.join("spec/fixtures", path))
  end
end
