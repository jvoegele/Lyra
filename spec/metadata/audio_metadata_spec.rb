require 'metadata/audio_metadata_shared_examples'

include Lyra::Metadata

describe AudioMetadata do
  it_behaves_like "AudioMetadata"

  before(:each) do
    @metadata = AudioMetadata.new
  end
end
