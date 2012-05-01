require 'spec_helper'
require 'metadata/audio_metadata_shared_examples'

include Lyra::Metadata

describe TrackMetadata do
  it_behaves_like "AudioMetadata"

  before(:each) do
    @metadata = TrackMetadata.new(AlbumMetadata.new)
  end

  it "requires a reference to its containing album on creation" do
    -> {TrackMetadata.new}.should raise_error(ArgumentError)
    -> {TrackMetadata.new(title: 'A Song')}.should raise_error(ArgumentError)
    -> {TrackMetadata.new("not_an_album", title: 'Song 2')}.should raise_error(ArgumentError)
    -> {TrackMetadata.new(AlbumMetadata.new, title: 'Sing Song')}.should_not raise_error
  end

  it "inherits values from its containing album" do
    album = AlbumMetadata.new(artist: 'Nine Inch Nails', album: 'Broken', date: 1992)
    album.add_track 'Pinion'
    album << 'Wish'
    album.add_track(TrackMetadata.new(album, title: 'Last'))
    album << TrackMetadata.new(album, title: 'Help Me I Am in Hell')
    album << 'Happiness in Slavery'
    album << 'Gave Up'

    album.tracks.should have_exactly(6).items
    album.tracks.each_with_index do |track, i|
      track.artist.should == 'Nine Inch Nails'
      track.album.should == 'Broken'
      track.date.should == '1992'
    end
  end
end
