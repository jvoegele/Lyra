require 'spec_helper'
require 'metadata/audio_metadata_shared_examples'

include Lyra::Metadata

describe AlbumMetadata do
  it_behaves_like "AudioMetadata"

  let(:metadata) {
    AlbumMetadata.new
  }

  context "#tracks" do
    it "is initially empty" do
      metadata.tracks.should be_empty
    end

    it "can add tracks as TrackMetadata objects" do
      track = TrackMetadata.new(title: 'Track 1')
      metadata.add_track(track)
      metadata.tracks.should have_exactly(1).items
      metadata.tracks.first.title.should == 'Track 1'
    end

    it "can add tracks as Strings" do
      metadata.add_track('Trilogy')
      metadata.tracks.should have_exactly(1).items
      metadata.tracks.first.title.should == 'Trilogy'
    end

    it "automatically adds track numbers for added tracks" do
      metadata.add_track('American Idiot')
      metadata.tracks.first.tracknumber.should == '01'
    end

    it "aliases << for add_track" do
      metadata << 'Some Track'
      metadata.tracks.first.title.should == 'Some Track'
      metadata.tracks.first.tracknumber.should == '01'
    end
  end
end
