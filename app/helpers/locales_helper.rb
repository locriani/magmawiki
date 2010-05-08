module LocalesHelper
  # stuff, very much wip
  # needed: available_locales lookup in human readable format
  # for html output / selection
  # such as : Language: English
  # or : Linguini: Pasta (blah)
  # which will make use of the self key in the locales files
  def available_locales
    output = []
    I18n.available_locales.each do |locale|
      y = LabelValue.new
      y.label = locale
      y.value = (I18n.t 'self', :locale => locale)
      output.push(y)
    end
    return output
  end
  
  class LabelValue
  attr_accessor :label, :value
  end
end
