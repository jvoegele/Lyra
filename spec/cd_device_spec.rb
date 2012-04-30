require 'spec_helper'
include Lyra

describe CdDevice do
  it "detects the default device" do
    CdDevice.default_device.should be_kind_of(String)
  end

  let(:first_track_num) { SpecHelper.fake_cd_info[0] }
  let(:sectors) { SpecHelper.fake_cd_info[1] }
  let(:track_offsets) { SpecHelper.fake_cd_info[2] }

  it "can be initialized with disc information" do
    cd_device = CdDevice.new(first_track_num, sectors, track_offsets)
    disc_info = cd_device.disc_info
    disc_info.first_track_num.should == first_track_num
    disc_info.sectors.should == sectors
    disc_info.tracks.map {|t| t.start_sector}.should == track_offsets
    disc_info.last_track_num.should == track_offsets.size
  end

  it "it obtains information from a CD device if given a device path" do
    cd_device = CdDevice.new
    cd_device.should_receive(:mb_disc_id).and_return {
      disc_id = MusicBrainz::DiscID.new
      disc_id.put(first_track_num, sectors, track_offsets)
      disc_id
    }
    disc_info = cd_device.disc_info
    disc_info.should_not be_nil
  end
end