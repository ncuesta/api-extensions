require 'api/extensions/fields'

Before do
  @fields_processor = Object.new
  class << @fields_processor
    include(Api::Extensions::Fields)
  end
end

def required_fields
  %w(links)
end


Given /^I get the fields parameter "(.*)"$/ do |value|
  @fields = value
end

When /^I process the fields parameter$/ do
  @result = @fields_processor.process_fields @fields, @response, @request_path
end

Then /^the resulting response should include the required fields$/ do
  required_fields.each do |field|
    assert_include @result, field, "The field #{field} is not included"
  end
end

Then /^the resulting response should (contain|not contain) all the non-required fields$/ do |contain|
  assert_equal @response.keys, @result.keys, 'At least one non-required field is missing' if contain == 'contain'
end

Then /^the resulting response should only contain "(.*)" as non-required fields$/ do |specific_fields|
  specific_fields = specific_fields.split ','

  if specific_fields.length > 0
    keys = @result.keys - required_fields
    assert keys.reject { |k| keys.include? k }.empty?, 'Some extra keys were found but not expected'
  end
end

Then(/^the resulting response should be the same as the original one$/) do
  assert_equal @response, @result, 'The response has changed'
end

Then(/^the resulting response should include a link to the full resource$/) do
  assert @response['links'].has_key?('full'), 'The response lacks a "full" link'
  assert_equal @request_path, @response['links']['full']['href'], 'The "full" link is wrong'
end