raw_config = File.read(RAILS_ROOT + "/config/magmawiki_config.yml")
MAGMAWIKI_CONFIG = YAML.load(raw_config)['magmawiki'].symbolize_keys

I18n.locale = MAGMAWIKI_CONFIG[:locale][:default]