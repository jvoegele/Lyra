require 'spec_helper'
require 'metadata/audio_metadata_shared_examples'

include Lyra::Metadata

describe TrackMetadata do
  it_behaves_like "AudioMetadata"

end
