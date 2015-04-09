# Paramedic

Paramedic provides parameters with a little extra help in dealing with some finnicky legacy systems.

## Installation

Add this line to your application's Gemfile:

    gem 'paramedic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paramedic

## Usage

### Encoder

Encoder takes a hash of params and their values, and makes them safe for older Microsoft services, like so:

    > params = { CMD: '/cmd?name=bill&id=3' }
    > Paramedic::Encoder.new(params).to_s
    => "CMD=%2Fcmd%3Fname%3Dbill%24id%3D3"

### XmlMasseuse

Let's say that you have an XML document assigned to a variable like so:

    > xml = """
    ...
    <superheroes>
      <superman>
        <name>Clark Kent</name>
      </superman>
    </superheroes>
    ...
    """

If you want the <superheroes /> element's children to be treated like they're not part of the XML document,
do the following:

    > Paramedic::XmlMasseuse.new(xml: xml, escape_tags: ['superheroes']).to_xml

The result will be the following string:

    => <superheroes>&lt;superman&gt;&lt;name&gt;Clark Kent&lt;/name&gt;</superheroes>

## Contributing

1. Fork it ( https://github.com/ryancammer/paramedic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
