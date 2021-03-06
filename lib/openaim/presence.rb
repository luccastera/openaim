require 'rubygems'
require 'xmlsimple'
require 'net/http'

module OpenAIM
  
  PRESENCE_BASE_URL = 'http://api.oscar.aol.com/presence/'
  
  class Presence
  
    attr_reader :key
    
    def initialize(key)
      @key = key
    end
    
    def get(usernames)      
      usernames = [usernames] if usernames.class == String
      
      url = PRESENCE_BASE_URL + "get?k=#{self.key}&f=xml"
      usernames.each do |username|
        url << "&t=#{username}"
      end
            
      xml_data = Net::HTTP.get_response(URI.parse(url)).body
      
      data = XmlSimple.xml_in(xml_data)
      
      users = []
      data['data'][0]["users"][0]['user'].each do |item|
        user = OpenAIM::User.new
        user.aim_id = item["aimId"][0] if item["aimId"]
        user.display_id = item["displayId"][0] if item["displayId"]
        user.status = item["state"][0] if item["state"]
        user.online_time = item["onlineTime"][0] if item["onlineTime"]
        user.away_time = item["awayTime"][0] if item["awayTime"]
        user.user_type = item["userType"][0] if item["userType"]
        user.buddy_icon = item["buddyIcon"][0] if item["buddyIcon"]
        user.presence_icon = item["presenceIcon"][0] if item["presenceIcon"]
        users << user  
      end

      if users.size == 1
        users[0]
      else
        users
      end
    end
  
  end
  
  
  class User
    attr_accessor :aim_id, :display_id, :status, :online_time, :away_time, :user_type, :buddy_icon, :presence_icon
  
    def initialize
      @aim_id = ''
      @display_id = ''
      @status = ''
      @online_time = ''
      @away_time = ''
      @user_type = ''
      @buddy_icon = ''
      @presence_icon = ''
    end
    
    def is_online?
      @status == 'online'
    end

  end

end
