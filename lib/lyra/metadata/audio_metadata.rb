module Lyra::Metadata

  class AudioMetadata
    def initialize(hash={})
      @data = Hash.new
      hash.each do |key, value|
        self[key] = value
      end
    end

    def [](field_name)
      get(field_name)
    end

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
      result = @data[field_name_for(field_name)]
      result.dup if result
    end

    def set(field_name, value)
      if field_name && value
        name = field_name_for(field_name)
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

    def field_name_for(name)
      name.to_s.upcase
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
