Rails.application.config.middleware.use OmniAuth::Builder do 
  require 'openid/store/filesystem'
  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name=>:google, :identifier=>"https://www.google.com/accounts/o8/id"
  provider :twitter, 'EeiFu6gjVQUI5DLhEgmwvg', 'FoDLohEru9EbE7WnjPlw5Nst3hk9bbf7pOfC3zXp8'
  provider :linked_in, 'OW_yeXmsWf9drBvNGqaRohalpsr-fBMLNm7Oa25NEtG_wjRHQm4wsBM8BLAMD5ij','zN5iOVFtQhUnfW8FHG5tVrLeKraIim9ghT28dxTKXWj85ZBO8PJn7_Jusn2W-r1y'
  provider :facebook, '208841802470446', 'ac91175f2bc13e7ff4576b8a368a8ab2',:scope=>'email'
end
