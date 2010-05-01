# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def define_toolbar_variables(input_parameters = {})
    expected_parameters = {:article           => nil,
                           :article_active    => false,
                           :talk_forum        => nil,
                           :talk_forum_active => false,
                           :read_active       => false,
                           :edit_active       => false,
                           :history_active    => false,
                           :star_active       => false,
                           :menu_active       => false }
                           
    return expected_parameters.merge(input_parameters)
  end
  def captcha
    CAPTCHA
  end
end
