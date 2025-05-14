module Validations
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate(attribute, options = {})
      validations[attribute] ||= []
      validations[attribute] << options
    end

    def validations
      @validations ||= {}
    end
  end

  def validate!
    self.class.validations.each do |attribute, rules|
      rules.each do |rule|
        validate_attribute(attribute, rule)
      end
    end
  end

  private

  def validate_attribute(attribute, rule)
    value = send(attribute)

    # Presence validation
    validate_presence(value) if rule[:presence]

    # Type validation
    validate_type(value, rule[:type]) if rule[:type]

    # Positive validation
    validate_positive(value) if rule[:positive] && value.is_a?(Numeric)

    # Includes validation
    validate_includes(value, rule[:includes]) if rule[:includes]

    value
  end

  def validate_type(value, expected_type)
    return if value.nil?

    # Convert symbol to actual class if needed
    ruby_class = ruby_class(expected_type)

    if ruby_class == [TrueClass, FalseClass] && ![true, false].include?(value)
      raise ArgumentError, "#{value.class} is not a Boolean"
    end

    return validate_array_types(expected_type, value, ruby_class) if ruby_class.is_a?(Array)

    raise ArgumentError, "#{value.class} is not a #{expected_type}" unless value.is_a?(ruby_class)
  end

  def validate_array_types(expected_type, value, ruby_class)
    raise ArgumentError, "#{value.class} is not a #{expected_type}" unless ruby_class.any? do |type|
                                                                             value.is_a?(type)
                                                                           end
  end

  def ruby_class(expected_type)
    case expected_type
    when Symbol
      Object.const_get(expected_type.to_s.capitalize)
    else
      expected_type
    end
  end

  def validate_presence(value)
    case value
    when String
      raise ArgumentError, 'Value cannot be empty' if value.empty?
    when NilClass
      raise ArgumentError, 'Value cannot be nil'
    end
  end

  def validate_positive(value)
    raise ArgumentError, 'Value must be positive' unless value.positive?
  end

  def validate_includes(value, collection)
    raise ArgumentError, "Value must be included in #{collection}" unless collection.include?(value)
  end
end
