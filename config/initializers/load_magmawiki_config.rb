#TODO: HORRIBLE HACK
def recursively_symbolize_keys(obj)
  case obj
  when Array
    obj.inject([]){|res, val|
      res << case val
      when Hash, Array
        val.symbolize_keys
      else
        val
      end
      res
    }
  when Hash
    obj.inject({}){|res, (key, val)|
      nkey = case key
      when String
        key.to_sym
      else
        key
      end
      nval = case val
      when Hash, Array
        val.symbolize_keys
      else
        val
      end
      res[nkey] = nval
      res
    }
  else
    obj
  end
end
#TODO: WHAT THE FLYING FUCK THIS IS MESSY
raw_config = File.read(RAILS_ROOT + "/config/magmawiki_config.yml")
MAGMAWIKI_CONFIG = recursively_symbolize_keys(YAML.load(raw_config)['magmawiki'])

undef recursively_symbolize_keys

I18n.default_locale = MAGMAWIKI_CONFIG[:locale][:default].to_sym
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
CAPTCHA = Captcha::Recaptcha.new(MAGMAWIKI_CONFIG[:captcha])

