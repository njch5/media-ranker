ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"  # for Colorized output
#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def perform_login(user = nil)
    @user ||= User.first

    @login_data = {
      user: {
        username: @user.username,
      },
    }
    post login_path, params: @login_data

    # Verify the user ID was saved - if that didn't work, this test is invalid
    expect(session[:user_id]).must_equal @user.id

    return user
  end
end
