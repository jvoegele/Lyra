Given /^an audio CD with MusicBrainz DiscID "([^\"]*)"$/ do |disc_id|
  @disc_id = disc_id
end

When /^I lookup metadata for the CD$/ do
  musicbrainz = Lyra::Metadata::MusicBrainzMetadataService.new
  @album_metadata = musicbrainz.lookup_by_disc_id(@disc_id)
end

Then /^the "([^"]*)" field should be "([^"]*)"$/ do |field, value|
  @album_metadata[field].should == value.to_s
end

Then /^the tracks should be:$/ do |table|
  tracks = table.raw
  fields = tracks.first
  tracks.drop(1).each_with_index do |row, i|
    track = @album_metadata.tracks[i]
    fields.each_with_index do |field, j|
      track[field].should == row[j]
    end
  end
end
