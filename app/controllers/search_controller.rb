require 'open-uri'
require 'json'
require 'uri'
require 'mysql'
require 'rubygems'
require 'twitter'


class SearchController < ApplicationController
    
    def meta_resp
        userAgent = request.user_agent
      
      if userAgent =~ /iphone/i or userAgent =~ /ipad/i or userAgent =~ /ipod/i
          return '1.0'
      else
          return '0.67'
      end
        
    end
  def search
      ip = request.remote_ip
      userAgent = request.user_agent

      @meta = meta_resp

      url = 'http://allvisio.com/PHP/api.php?connexion='+ip.to_s+'&user_agent='+userAgent.to_s+'&secret=API_SECRET'
      open(url)
       
  end
    
    #Retrieve sur l'API google map
    def geo
        
        location        = params[:query]

        #API geocode, configurable
        url         = 'https://maps.googleapis.com/maps/api/geocode/json?address='+URI.escape(location)+'&key=AIzaSyBHh98RBg7JmbuGfuIVITP1uJRfAAiKspM';
        
        
        kittens     = open(url)
        
        @my_hash    = JSON.parse(kittens.read)
        respond_to do |format|
            format.json {render json:  @my_hash }
        end
       
   
    end
  
    def query
        
        query  = params[:query]
        lang   = params[:lang]
        type   = params[:type]
        avant  = params[:until]
        coor    = params[:coor]
        
        
        ip = request.remote_ip
        url = 'http://allvisio.com/PHP/api.php?ip='+ip.to_s+'&recherche='+query.to_s+'secret=API_SECRET'
      open(url)
        
        client = Twitter::REST::Client.new do |config|
            config.consumer_key        = "4fLUMpoGpGnDmc2eG6xS0RBch"
            config.consumer_secret     = "JBtQNCSJcBdCTYzjWW4u6Mf97r9e9gMcwgZUCFY3PQSKmBDmhC"
            config.access_token        = "4614362362-2NWVlEeZgcmzvkXBrjtXBx9JU27ej9vdLTDMuPi"
            config.access_token_secret = "muOqc9HAh6zjF3YgNtz0sjjd0qsSVoBVL9qvAKyYi9slh"
        end

        search_options = {
            result_type: type,
            lang: lang,
            until: avant,
            geocode: coor,
            count: 30,
        }
        
        tabURL = Array.new
        
        
        client.search("#{query}", search_options).take(30).each do |tweet|
            
            url = "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
            
            tabURL.push(url)
            
        end
        @result = tabURL.to_s

        respond_to do |format|
            format.js {render js:  @result }
        end
    end
    
end
