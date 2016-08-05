require 'open-uri'

class LoginController < ApplicationController
    def meta_resp
        userAgent = request.user_agent
      #if userAgent.scan(/iphone/i) or userAgent.scan(/ipad/i) or userAgent.scan(/ipod/i)
      if userAgent =~ /iphone/i or userAgent =~ /ipad/i or userAgent =~ /ipod/i
          return '1.0'
      else
          return '0.67'
      end
        
    end
  def login
     # me = Membre.new
     # me.ip = request.remote_ip
    #  me.save
      @meta = meta_resp
      ip = request.remote_ip
      url = 'http://allvisio.com/PHP/api.php?membre='+ip.to_s
      open(url)
  end
end
