require 'api/extensions/expand'

Before do
  @expand_processor = Object.new
  class << @expand_processor
    def get url
    end

    include(Api::Extensions::Expand)
  end
end

Given(/^I get the expand parameter "(.*)"$/) do |value|
  @expand = value
end

When(/^I process the expand parameter$/) do
  @result = @expand_processor.process_expand @expand, @response
end

Then(/^the resulting response should include the original response$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the resulting response should also contain "(.*?)" as new attributes$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the resulting response should have the entries expanded$/) do
  pending # express the regexp above with the code you wish you had
end