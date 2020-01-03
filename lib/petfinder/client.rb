module Petfinder
  class Client

    include Api

    def initialize(api_key = Petfinder.api_key, api_secret = Petfinder.api_secret)
      @api_key = api_key
      @api_secret = api_secret

      raise Petfinder::Error.new("API key is required") unless @api_key
      raise Petfinder::Error.new("API secret is required") unless @api_secret
    end

    def request(path, params = {})
      response = token.get(path, params: params).parsed

      response

    rescue OAuth2::Error => e
      error_data = JSON.parse(e.response.body)
      raise Petfinder::Error.new(error_data), "#{error_data["title"]}: #{error_data["detail"]}"
    end

    def oauth_client
      @oauth_client ||= OAuth2::Client.new(@api_key, @api_secret, site: Petfinder::API_URL, token_url: 'oauth2/token')
    end

    def token
      @token = nil if @token&.expired?

      @token ||= oauth_client.client_credentials.get_token
    end

  end
end
