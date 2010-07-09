module Petfinder
  
  class Auth
    include HappyMapper

    tag 'auth'
    element :key, String
    element :token, String
    element :expires, String
    element :expiresString, String
  end

end
