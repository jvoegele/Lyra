require 'spec_helper'
require 'metadata/audio_metadata_shared_examples'

include Lyra::Metadata

describe TrackMetadata do
  it_behaves_like "AudioMetadata"

  before(:each) do
    @metadata = TrackMetadata.new(AlbumMetadata.new)
  end

  let(:tracks) {
    ['Pinion', 'Wish', 'Last', 'Help Me I Am in Hell', 'Happiness in Slavery', 'Gave Up']
  }
  let(:broken) {
    album = AlbumMetadata.new(artist: 'Nine Inch Nails', album: 'Broken', date: 1992)
    album.add_track tracks[0]
    album << tracks[1]
    album.add_track(TrackMetadata.new(album, title: tracks[2]))
    album << TrackMetadata.new(album, title: tracks[3])
    album << tracks[4]
    album << tracks[5]
    album
  }

  it "requires a reference to its containing album on creation" do
    -> {TrackMetadata.new}.should raise_error(ArgumentError)
    -> {TrackMetadata.new(title: 'A Song')}.should raise_error(ArgumentError)
    -> {TrackMetadata.new("not_an_album", title: 'Song 2')}.should raise_error(ArgumentError)
    -> {TrackMetadata.new(AlbumMetadata.new, title: 'Sing Song')}.should_not raise_error
  end

  it "inherits values from its containing album" do
    broken.tracks.should have_exactly(6).items
    broken.tracks.each_with_index do |track, i|
      track.artist.should == 'Nine Inch Nails'
      track.album.should == 'Broken'
      track.date.should == '1992'
      track.title.should == tracks[i]
    end
  end

  it "overrides values from its containing album" do
    track = broken.tracks[1]
    track.artist.should == broken.artist
    track.artist = 'Trent Reznor'
    track.artist.should_not == broken.artist
    broken.artist.should == 'Nine Inch Nails'
    track.artist.should == 'Trent Reznor'
  end

  it "overrides has_field? to check containing album" do
    track = broken.tracks[4]
    track.should have_field('album')
    track.should have_field('date')
  end
end
