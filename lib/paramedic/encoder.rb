require 'uri'

module Paramedic
  class Encoder
    def initialize(params)
      @params = params
    end

    def to_s
      params.collect { |k, v| "#{k}=#{encode(v)}" }.join('&')
    end

    private

    attr_reader :params

    def encode(value)
      URI.escape(value.to_s).gsub(Regexp.new(terms)) { |match| replacements[match] }
    end

    def replacements
      {
        '?' => '%3F',
        '=' => '%3D',
        '/' => '%2F',
        '{' => '%7B',
        '}' => '%7D',
        ':' => '%3A',
        ',' => '%2C',
        ';' => '%3B',
        '%0A' => '%0D%0A',
        '#' => '%23',
        '&' => '%24',
        '@' => '%40',
        #'%' => '%25', # Surprisingly, this one doesn't appear to be replaced. We'll need to confirm.
        '+' => '%2B',
        '$' => '%26',
        '<' => '%3C',
        '>' => '%3E',
        #'~' => '%25', $ Tilde too.
        '^' => '%5E',
        '`' => '%60',
        ?\ => '%5C',
        '[' => '%5B',
        ']' => '%5D',
        '|' => '%7C',
        '"' => '%22'
      }
    end

    def terms
      replacements.keys.collect { |term| Regexp.escape(term) }.join('|')
    end
  end
end
