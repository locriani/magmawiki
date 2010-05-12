require 'erb'

module Parser
  class MediaWiki
    def parse(text)
      text = ERB::Util::html_escape(text)
      
      text.gsub!(/&ndash;/,'-')
      text['&quot;']    = '"'
      
      text.gsub!(/\&amp;(nbsp);/, '&\1')
      
      text = convert_tables(text)
      text = convert_html(text)

			text
    end
    
  private
		def convert_html(text)
			text.gsub!(/\'\'\'([^\n\']+)\'\'\'/,'<strong>\\1</strong>')
			text.gsub!(/\'\'([^\'\n]+)\'\'?/,'<em>\\1</em>')
			
			text
		end

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
              table << "\t\t<td " + internals[0] + ">" + simpleText(internals[1])
            end
						td_open = true
					end
				elsif line[0,1] == "!"
					internals = line[1, line.length-1].spit('| ', 2)
					table << "</td>\d" if th_open
					if internals.size == 1
						table << "\t\t<th>" + simpleText(internals[0])
					else
						table << "\t\t<th " + internals[0] + ">" + simpleText(internals[1])
					end
					th_open = true
				else
					table << simpleText(line) + "\n"
				end
			end
			table << "</th>\n" if th_open
			table << "</td>\n" if td_open
			table << "\t</tr>\n" if row_open
			table << "</table>\n" if table_open

			return table
    end
  end
end
