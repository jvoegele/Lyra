module Lyra::Metadata

  # Metadata for an audio track or a collection of audio tracks such as an album.
  #
  # Audio metadata is represented as a collection of "fields", each of which
  # has a name and one or more values.
  #
  # Field names are free-form and this class does not restrict fields to a
  # predefined set of known field names.  However, for some common fields
  # there are constants containing the name of the field and accessor
  # functions for getting and setting the field value.  In all cases, field
  # names are case-insensitive wherever they are used by this class.  Thus,
  # the field name ARTIST is equivalent to both Artist and artist, and all
  # can be used interchangebly.  The original case of the field name is
  # preserved.
  #
  # The term "field" is used in preference to the more common "tag" because
  # the latter term is used by some to refer to an individual field of
  # metadata (e.g. "the ARTIST tag"), while others use it to refer to a
  # collection of metadata fields (e.g. "the ID3v2 tag").  Using the term
  # "field" avoids this ambiguity, as it always refers to an individual
  # field of metadata.
  class AudioMetadata

    # Returns the normalized form of the given name. The normalized form is
    # defined as name.to_s.upcase.
    def self.field_name_for(name)
      name.to_s.upcase
    end

    # Create a new AudioMetadata object. If the optional hash argument is given,
    # it is used to initialize the fields of this metadata object.
    def initialize(hash={})
      @data = Hash.new
      hash.each do |key, value|
        self[key] = value
      end
    end

    # Is there a field with the given field_name? Note that this method returns
    # true as long as the field_name is present, even if its associated value
    # is nil or false.
    def has_field?(field_name)
      @data.has_key?(AudioMetadata.field_name_for(field_name))
    end

    # Returns the value of the given field_name, or nil if the field is not present.
    # Note that the value may be an Array if multiple values are present for the
    # given field_name.
    def [](field_name)
      get(field_name)
    end

    # Sets the value for the given field_name, overwriting any existing values
    # associated with field_name. Note that value may be an Array if multiple
    # values are desired for the given field name.
    #
    # Internally, the field_name is normalized using the
    # AudioMetadata.field_name_for(name) method prior to being stored.
    def []=(field_name, value)
      set(field_name, value)
    end

    def method_missing(name, *args)
      name = name.to_s.gsub(/=$/, '')
      case args.size
      when 0
        self[name.to_s]
      when 1
        self[name.to_s] = args.first
      else
        super
      end
    end

  protected

    def get(field_name)
      result = @data[AudioMetadata.field_name_for(field_name)]
      result.dup if result
    end

    def set(field_name, value)
      if field_name
        name = AudioMetadata.field_name_for(field_name)
        @data[name] = case value
        when String, Array
          value.dup
        when Enumerable
          value.to_a
        else
          value.to_s
        end
      end
    end

  end
end

__END__

# This was an experiment.
class FieldValue
  attr_reader :name, :values
  def initialize(name, *values)
    @name = name.dup
    @values = values
  end

  def <<(value)
    @values << value
  end

  def to_s
    @values.join(';')
  end

  def to_str
    self.to_s
  end

  def ==(other)
    case other
    when FieldValue
      self.name == other.name && self.values == other.values
    when String
      values.size == 1 && values.first == other
    when Array
      values == other
    else
      false
    end
  end
end
