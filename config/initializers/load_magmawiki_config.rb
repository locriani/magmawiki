MAGMAWIKI_CONFIG = YAML::load(File.read(::Rails.root.to_s + "/config/magmawiki_config.yml").untaint)['magmawiki'].with_indifferent_access

I18n.default_locale = MAGMAWIKI_CONFIG[:locale][:default].to_sym
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
