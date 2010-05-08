module LocalesHelper
  #stuff, very much wip
  # needed: available_locales lookup in human readable format
  # for html output / selection
  # such as : Language: English
  # or : Linguini: Pasta (blah)
  # which will make use of the self key in the locales files
  def available_locales
    I18n.available_locales
  end
end
