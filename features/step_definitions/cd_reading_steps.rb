Given /^that there is a CD in the CD\-ROM drive$/ do
end

Given /^the first track number on the CD is (\d+)$/ do |num|
  @first_track_num = num
end

Given /^the CD has (\d+) sectors$/ do |sectors|
  @sectors = sectors
end

Given /^the CD has the following track offsets:$/ do |table|
  @track_offsets = table.raw.flatten
end

When /^CD information is read from the CD$/ do
  @cd_device = Lyra::CdDevice.new(@first_track_num, @sectors, @track_offsets)
  @disc_info = @cd_device.disc_info
end

Then /^the MusicBrainz Disc ID should be "([^\"]*)"$/ do |disc_id|
  @disc_info.musicbrainz_disc_id.should == disc_id
end

Then /^the FreeDB ID should be "([^\"]*)"$/ do |freedb_id|
  @disc_info.freedb_id.should == freedb_id
end

Then /^there should be (\d+) sectors$/ do |sectors|
  @disc_info.sectors.should == sectors
end

Then /^the first track number should be (\d+)$/ do |num|
  @disc_info.first_track_num.should == num
end

Then /^the last track number should be (\d+)$/ do |num|
  @disc_info.last_track_num.should == num
end

Then /^the total length should be (\d+) seconds$/ do |seconds|
  @disc_info.duration.should == seconds
end

def format_duration(duration)
  Lyra::TimeHelper.format_duration(duration)
end

Then /^the track information should be:$/ do |table|
  table.raw.drop(1).each_with_index do |row, i|
    track = @disc_info.tracks[i]
    track.number.should == row[0].to_i
    track.sectors.should == row[1].to_i
    track.start_sector.should == row[2].to_i
    track.end_sector.should == row[3].to_i
    format_duration(track.duration).should == row[4]
    format_duration(track.start_time).should == row[5]
    format_duration(track.end_time).should == row[6]
  end
end
