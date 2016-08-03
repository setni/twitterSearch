class LoginController < ApplicationController
  def login
      me = Membre.new
      me.ip = request.remote_ip
      me.save
  end
end
