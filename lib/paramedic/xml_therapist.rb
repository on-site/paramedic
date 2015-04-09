require 'nokogiri'

module Paramedic
  class XMLTherapist
    def massage(xml)
      Nokogiri::XML(xml){
        |x| x.noblanks
      }.to_xml(
        save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
      )
    end
  end
end
