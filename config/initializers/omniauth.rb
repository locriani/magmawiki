Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :facebook, '183517451659073', 'c4994a19ad6f467a360e1e3509e6676d'
end