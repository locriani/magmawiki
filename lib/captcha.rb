module Captcha  
  class Recaptcha
    def initialize(options = {})
      @global_settings = {
                          :global_settings  => true,
                          :enabled          => false,
                          :public_key       => nil,
                          :private_key      => nil,
                          :captcha_provider => :recaptcha,
                          :environments     => {
                            :cucumber         => false,
                            :test             => false,
                            },
                          }
      @global_settings = build_instance_options(options)
    end
    
    def enabled?
      return @global_settings[:enabled]
    end
    
    def recaptcha_tags(options = {})
      output = ""
      if self.enabled?
        options = build_instance_options(options)
        output = html_tags(options)
      end
      return output
    end

    def verify_recaptcha(options = {})
      if self.enabled?

      else
        return true
      end
    end

  private
    def build_instance_options(options = {})
      @global_settings.merge(options)
    end
    
    def html_tags(options)
      tags = %{<script type="text/javascript"
      src="http://api.recaptcha.net/challenge?k=#{options[:public_key].to_s}">
      </script>
      <noscript>
      <iframe src="http://api.recaptcha.net/noscript?k=#{options[:public_key].to_s}"
      height="300" width="500" frameborder="0"></iframe><br>
      <textarea name="recaptcha_challenge_field" rows="3" cols="40">
      </textarea>
      <input type="hidden" name="recaptcha_response_field" 
      value="manual_challenge">
      </noscript>}
    end
  end
end