module SongsHelper
    def self.artist_switch(id) 
        Artist.exists?(id: id)
    end 
    def self.am_valid?(id) 
        Artist.exists?(id: id)
    end
    
end
