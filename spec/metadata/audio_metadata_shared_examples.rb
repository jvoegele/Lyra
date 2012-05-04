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

  it "detects the presence of fields" do
    metadata.should_not have_field('arbitrary')
    metadata.should_not have_field('ARBITRARY')
    metadata['arbitrary'] = '42'
    metadata.should have_field('ARBITRARY')
    metadata.should have_field('arbitrary')

    metadata.should_not have_field('compilation')
    metadata.compilation = false
    metadata.should have_field('compilation')

    metadata.should_not have_field('careless')
    metadata['careless'] = nil
    metadata.should have_field('careless')
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

  context "#each" do
    it "yields the field_name and associated value(s)" do
      metadata.artist = 'Nirvana'
      metadata['genre'] = %w[Rock Grunge]
      metadata.each do |name, val|
        case name
        when /genre/i
          val.should == %w[Rock Grunge]
        when /artist/i
          val.should == 'Nirvana'
        end
        
      end
    end
  end
end
