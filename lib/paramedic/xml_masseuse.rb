require 'nokogiri'
require 'cgi'

module Paramedic
  class XMLMasseuse
    def initialize(xml, opts={})
      @xml = xml
      @escape_tags = opts.fetch(:escape_tags, [])
    end

    def to_xml
      strip_tag_spacing(
        escape_specified_tags(
          Nokogiri::XML(remove_naked_ampersands(xml), &:noblanks)
        )
      )
    end

    private

    def remove_naked_ampersands(text)
      text.gsub('&', '&amp;')
    end

    def escape_specified_tags(xml_document)
      escape_tags.each do |escape_tag|
        xml_document.css(escape_tag).each do |element|
          strip_tag_spacing(element)
          element.inner_html = CGI.escape_html(element.inner_html)
        end
      end

      xml_document
    end

    def strip_tag_spacing(xml_document)
      xml_document.to_xml(
        save_with: Nokogiri::XML::Node::SaveOptions::AS_XML |
          Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
      )
    end

    attr_reader :escape_tags, :xml
  end
end
