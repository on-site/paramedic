require 'nokogiri'
require 'cgi'

module Paramedic
  class XMLMasseuse
    def initialize(xml, opts={})
      @xml = xml
      @escape_tags = opts.fetch(:escape_tags, [])
    end

    def to_xml
      xml_document = Nokogiri::XML(xml, &:noblanks)
      escape_tags.each do |escape_tag|
        xml_document.css(escape_tag).each do |element|
          strip_tag_spacing(element)
          element.inner_html = CGI.escape_html(element.inner_html)
        end
      end
      strip_tag_spacing(xml_document)
    end

    private

    def strip_tag_spacing(xml)
      xml.to_xml(
        save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
      )
    end

    attr_reader :escape_tags, :xml
  end
end
