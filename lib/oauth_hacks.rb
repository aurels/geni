class OAuth2::AccessToken
  # Fix bug introduced in https://github.com/intridea/oauth2/commit/607af1ca78fa20b796de6260aa143117bc712551
  def request(verb, path, params = {}, headers = {})
    params = params.merge token_param => @token
    headers = headers.merge 'Authorization' => "Token token=\"#{@token}\""
    @client.request(verb, path, params, headers)
  end
end