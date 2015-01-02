require_relative 'feature_test_helper'

class IdentifierTest < FeatureTest
  def test_it_shows_page
    post '/sources', identifier = "jumpstartlab"
    assert last_response.ok?
  end

end
