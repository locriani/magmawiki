class Revision < ActiveRecord::Base
  # belongs_to :article
  has_one :article
end
