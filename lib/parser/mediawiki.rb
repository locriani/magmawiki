require 'erb'

module Parser
  class MediaWiki
    def parse(text, options = {})
      assign_options(options)
      text = ERB::Util::html_escape(text)
      text = parse_mediawiki_headers(text)
      text = parse_linebreaks(text)
      text
    end
    
  private    
    def assign_options(options)
      
    end
    
    def parse_mediawiki_headers(text)
      
      6.downto 1 do |n|
        text.gsub!(/[=]{#{n}}(.+)[=]{#{n}}/, "<h#{n}>\\1</h#{n}>")
      end
      
      text
    end
    
    def parse_linebreaks(text)
      text = parse_html_linebreaks(text)
      text = parse_mediawiki_linebreaks(text)
      
      text
    end
    
    def parse_html_linebreaks(text)
      text.gsub!(/&lt;[\s]*br[\s]*[\/]*[\s]*&gt;/, '<br />')
      
      text
    end
    def parse_mediawiki_linebreaks(text)
      text.gsub!(/[\n]{2}/, '</p>')
      text.gsub!(/\z/, '</p>')
      text.gsub!(/\A/, '<p>')
      
      text
    end
  end
end