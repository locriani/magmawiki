module Captcha  
  class Recaptcha
    def initialize(options = {})

    end

    def recaptcha_tags(options = {})
      if self.enabled?
        return html_tags
      else
        return ""
      end
    end

    def verify_recaptcha(options = {})
      if self.enabled?

      else
        return true
      end
    end

    def html_tags 
      tags = %{<script type="text/javascript"
      src="http://api.recaptcha.net/challenge?k=#{@public_key}">
      </script>
      <noscript>
      <iframe src="http://api.recaptcha.net/noscript?k=#{@public_key}"
      height="300" width="500" frameborder="0"></iframe><br>
      <textarea name="recaptcha_challenge_field" rows="3" cols="40">
      </textarea>
      <input type="hidden" name="recaptcha_response_field" 
      value="manual_challenge">
      </noscript>}
    end
  end
end