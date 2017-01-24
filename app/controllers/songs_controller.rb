class SongsController < ApplicationController
  def index
    @artist_id = params[:artist_id]
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
    @artist_id = params[:artist_id]

    if params[:artist_id]
      if Artist.exists?(params[:artist_id])
        artist = Artist.find_by(id: params[:artist_id])
        @song = artist.songs.build
      else
      redirect_to artists_path, alert: "Artist not found"
      end
    else
      @song = Song.new
    end

  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @artist_id = params[:artist_id]
    if params[:artist_id] && Artist.exists?(params[:artist_id])
      artist = Artist.find_by(id: params[:artist_id])
      if Song.exists?(params[:id])
        @song = artist.songs.find_by(id: params[:id])
      else
        redirect_to artist_songs_path(artist), alert: "Song not Found"
      end
    elsif params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: "Artist not Found"
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
