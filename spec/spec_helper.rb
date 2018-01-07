RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.include FactoryGirl::Syntax::Methods
  config.order = :random
  config.profile_examples = 5

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
