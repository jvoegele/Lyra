#  -*- encoding:  utf-8 -*-

shared_examples_for "AudioMetadata" do

  let(:metadata) { @metadata }

  it "supports element reference notation" do
    metadata['ARTIST'].should be_nil
    metadata['ARTIST'] = 'Tricky'
    metadata['ARTIST'].should == 'Tricky'
  end

  it "is case insensitive" do
    metadata['GENRE'].should be_nil
    metadata['genre'] = 'Jazz'
    metadata['GENRE'].should == 'Jazz'
  end

  it "supports attribute accessor methods" do
    metadata.artist.should be_nil
    metadata.artist = 'Björk'
    metadata.artist.should == 'Björk'
    metadata.album.should be_nil
    metadata.album 'Volta'
    metadata.album.should == 'Volta'
  end

  it "supports multiple values for fields" do
    metadata['genre'].should be_nil
    metadata['genre'] = %w[Rock Grunge]
    metadata['genre'].should == ['Rock', 'Grunge']
  end

  it "can be initialized with a Hash" do
    unless described_class == TrackMetadata
      metadata = described_class.new(artist: 'Wilco', album: 'The Whole Love')
      metadata.artist.should == 'Wilco'
      metadata.album.should == 'The Whole Love'
    end
  end
end
