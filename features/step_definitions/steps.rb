Given(/^a query string that requires encoding$/) do
  @params = {}
end

Given(/^a value for (\w+)? in (\w+.xml)$/) do |key, file|
  @params[key] = Paramedic::XMLMasseuse.new(File.readlines("features/support/#{file}").join('')).to_xml
end

And(/^a value for (\w+)? of (\w+)?/) do |key, value|
  @params[key] = value
end

When(/^the keys and values are encoded$/) do
  @result = Paramedic::Encoder.new(@params).to_s
end

Then(/^they produce the string in (.+)?$/) do |output_file|
  expected_output = File.readlines("features/support/#{output_file}").first

  result_hash = produce_hash(@result)

  expected_hash = produce_hash(expected_output)

  result_hash.each_pair do |key, value|
    expected_value = expected_hash[key]

    expect(value.strip).to eq expected_value.strip
  end
end
