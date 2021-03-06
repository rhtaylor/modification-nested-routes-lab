class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new  
    
    if params[:artist_id] 
         @switch = SongsHelper.artist_switch(params[:artist_id])
      if !(@switch)
          redirect_to artists_path
      end
    end 
      @artist = Artist.find_by(id: params[:artist_id])
    @song = Song.new(artist_id: params[:artist_id])
  end

  def create 
    
      @switch = SongsHelper.am_valid?(params[:song][:artist_id])
       if !(@switch) 
        redirect_to artists_path 
       end
    @song = Song.new(song_params)
    if @song.valid?
     @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit  
    if params[:artist_id] 
      @artist = Artist.find_by(id: params[:artist_id])  
        if  @artist.nil? 
          redirect_to artists_path 
        else 
           @song_array = @artist.songs.where(id: params[:id]) 
              if @song_array.empty? 
              redirect_to artist_songs_path(@artist)
              else 
                @song = @song_array.first 
                @song 
                
              end
        end 
     else 
      @song = Song.find(params[:id]) 
     end 
  end

  def update 
    
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end

