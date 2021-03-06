module SongsHelper
  def artist_select(song, artist_id)
    if artist_id.nil?
      select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
    else
      hidden_field_tag 'song[artist_id]', song.artist.id
      label_tag "song[artist_name]"
      text_field_tag "song[artist_name]"
    end
  end
end
