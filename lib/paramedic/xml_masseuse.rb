require 'nokogiri'

module Paramedic
  class XMLMasseuse
    def initialize(xml:, double_encode: [])
      @xml = xml
      @double_encode = double_encode
    end

    def to_xml
      xml_document = Nokogiri::XML(xml){
        |x| x.noblanks
      }

      double_encode.each do |element_name|
        elements = xml_document.select(element_name)

        puts elements
      end

      xml_document.to_xml(
        save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
      )
    end

    private

    attr_reader :double_encode, :xml
  end
end
