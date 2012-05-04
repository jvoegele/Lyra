include Lyra::Metadata

describe MusicBrainzMetadataService  do
  let(:musicbrainz) {
    MusicBrainzMetadataService.new
  }
  let(:disc_id) {
    "ofNUMtU1O38OTXZBTop_w9LG.O4-"
  }

  context "#query" do
    let(:metadata) {
      musicbrainz.lookup_by_disc_id(disc_id)
    }
    it "finds a release when given a disc ID" do
      metadata.should_not be_nil
      metadata.should be_kind_of(AlbumMetadata)
    end

    it "chooses the release that matches the current locale region" do
      metadata.releasecountry.should == Locale.candidates.first.region
    end
  end
end