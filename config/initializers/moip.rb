class Moip
  attr_accessor :connection

  def initialize(auth = :basic, token = '', secret = '', mode = :sandbox)
    @connection = invoke_api_connection(auth, token, secret, mode)
  end

  def api
    yield(@connection) if block_given?
  end

  private

  def invoke_api_connection(auth, token, secret, mode)
    if auth == :basic
      # Basic Auth
      auth = Moip2::Auth::Basic.new(token, secret)
    elsif auth == :oauth
      # OAuth
      auth = Moip2::Auth::OAuth.new(token)
    end
    # Generating a client point
    client = Moip2::Client.new(mode, auth)
    # Get api from client
    api = Moip2::Api.new(client)
    # Returning
    api
  end
end
