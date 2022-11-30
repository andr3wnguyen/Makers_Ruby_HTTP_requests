require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

context "get /get-artists" do
  it "tests the /get-artists path" do
  response = get('/get-artists')
  expect(response.status).to eq 200
  expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
  end
end
context "post /artists" do
  it "adds an artist to the album" do
    response = post('/artists?name=Wild+nothing&genre=Indie')
    expect(response.status).to eq 200
    expect(response.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing'
  end
end

end