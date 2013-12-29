require './app'
require './middlewares/chat_backend'
require 'omniauth-openid'
require 'openid'
require 'openid/store/filesystem'
require 'gapps_openid'

use Rack::Session::Cookie, :secret => 'banbga342'

use OmniAuth::Builder do
  provider :open_id,  :name => 'admin',
                      :identifier => 'https://www.google.com/accounts/o8/site-xrds?hd=cloudon.com',
                      :store => OpenID::Store::Filesystem.new('/tmp')
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}


use Chat::ChatBackend


run Chat::App
