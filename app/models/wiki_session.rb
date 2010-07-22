class WikiSession < ActiveRecord::Base
  # This model does automagical wonderful things to link our different session types
  # to a revision (future: or a comment).
  
  # We can have:
  # IP Address ONLY sessions (no cookies)
  # IP + Cookie
  # User
  
  belongs_to :revision
  belongs_to :user
end
