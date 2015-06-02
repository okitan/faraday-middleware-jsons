require 'minitest_helper'

class TestFaraday::Middleware::Jsons < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Faraday::Middleware::Jsons::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
