class Revision < ActiveRecord::Base
  belongs_to :article, :counter_cache => :revision_count
end
