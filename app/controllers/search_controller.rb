require 'open-uri'
require 'json'
require 'uri'
require 'mysql'
require 'rubygems'
require 'twitter'


class SearchController < ApplicationController
    
    
  def search
      ip = request.remote_ip
      userAgent = request.user_agent
      
      if Connexion.find_by(ip: ip) != nil
          up = Connexion.find_by(ip: ip)
          old = up.nb
          up.nb = old+1
          up.save
      else nb = 1
          co = Connexion.new
          co.ip = ip
          co.user_agent = userAgent
          co.nb = 1
          co.date = Time.now
          co.save
      end
     
       
  end
    
    #Retrieve sur l'API google map
    def geo
        
        location        = params[:query]

        #API geocode, configurable
        url         = 'https://maps.googleapis.com/maps/api/geocode/json?address='+URI.escape(location)+'&key=AIzaSyBHh98RBg7JmbuGfuIVITP1uJRfAAiKspM';
        
        
        kittens     = open(url)
        # render :JSON
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
        
        recherche = Mysql.escape_string(query)
        re = Recherche.new
        re.recherche = recherche
        re.date = Time.now
        re.save
        
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
        #adress = Array.new
        
        client.search("#{query}", search_options).take(30).each do |tweet|
            #tabURL.push(tweet.id)
            url = "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
            #puts url
            #tabURL.push("<blockquote class='twitter-tweet'><a href='#{url}'></a></blockquote>")
            tabURL.push(url)
            #adress.push(url)
        end
        @result = tabURL.to_s

        respond_to do |format|
            format.js {render js:  @result }
        end
    end
    
end
