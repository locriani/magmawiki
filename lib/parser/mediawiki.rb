require 'erb'

module Parser
  class MediaWiki
    def parse(text)
      text = ERB::Util::html_escape(text)
      
      text['&ndash;']   = '-'
      text['&quot;']    = '"'
      
      text.gsub!(/\&amp;(nbsp);/, '&\1')
      
      text = convert_tables(text)
      text = convert_html(text)
    end
    
  private
    def convert_tables(text)
      lines = text.split("\n")
      
      inner_table = 0
      inner_table_data = []
      
      lines.each do |line|
        inner_table = (inner_table + 1) if line[0,2] == '{|'
        inner_table_data[inner_table] << line + "\n"
        if inner_table > 0
          if line[0,2] == '|}'
            inner_table_converted = convert_individual_table(inner_table_data[inner_table])
            inner_table_data[inner_table] = ""
            inner_table = inner_table - 1
            inner_table_data[inner_table] << inner_table_converted + "\n"
          end
        end
      end
      
      return inner_table_data[0]
    end
    
    def convert_individual_table(text)
      lines = text.split("\n")
      in_table = false;
      
      lines.each do |line|
        line.strip!
        if line[0,1] == '{'
          internals = line[1, line.length].split('| ', 2)
          table_open = true
          table = "<table " + internals[0] + ">\n"
        elsif line[0,1] == "|"
          line['|'] = ""
          if line[0,5] == '-----'
            table << "</th>\n"    if th_open
            table << "</td>\n"    if td_open
            table << "\t</tr>\n"  if row_open
            table << "\t<tr>\n"
            row_open = true
            td_open = false
            th_open = false
          elsif line[0,1] == '}'
            break
          else
            internals = line.split('| ', 2)
            table << "</td>\n" if td_open
            if internals.size == 1
              table << "\t\t<td>" + simpleText(internals[0])
            else
              # THIS IS WHERE I LEFT OFF THERE ARE STILL TAGS MISSING
            end
            
    end
  end
end
