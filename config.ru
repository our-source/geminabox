require 'rubygems'
require 'geminabox'

Geminabox.data = ENV.fetch 'RUBYGEMS_STORAGE', "#{__dir__}/data"

Geminabox::Server.helpers do
  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Geminabox")
      halt 401, "No pushing or deleting without auth.\n"
    end
  end

  def authorized?
    token_auth = request.env['HTTP_AUTHORIZATION']
    if request.path == '/upload' or request.post?
      if token_auth and token_auth.eql?((ENV.fetch("AUTH_TOKEN") { (0...50).map { ('a'..'z').to_a[rand(26)] }.join }))
        @app.call(env)  # token auth is ok
      else
        halt 401, "Access Denied. Api_key invalid or missing.\n"
      end
    else
      halt 401, "Access Denied. Api_key invalid or missing.\n"
    end
  end
end

Geminabox::Server.before '/upload' do
  protected!
end

Geminabox::Server.before do
  protected! if request.delete?
end

run Geminabox::Server
