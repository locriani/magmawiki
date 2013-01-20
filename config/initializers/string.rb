class String
  def slugify
    downcase.tr(' ','_').gsub(/[\!-\.;-@\[-\^`\{-~]/,"").gsub(/:/,":_").gsub(/(_{2,})/, '_').chomp("_")
  end
end