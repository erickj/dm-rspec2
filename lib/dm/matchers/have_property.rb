require 'debugger'
RSpec::Matchers.define :have_property do |property|
  chain :of_type do |type|
    @type = type
  end

  match do |model|
    model_class = model.is_a?(Class) ? model : model.class
    @has_property = model_class.properties.map(&:name).include? property
    if @type
      p = model_class.properties.find{|f| f.name == property}
      @has_property && p.class == @type
    else
      @has_property
    end
  end

  failure_message_for_should do |model|
    model_class = model.is_a?(Class) ? model : model.class
    if @type
      type = model_class.properties.find{|f| f.name == property}.class
      "property #{property} should be of type #{@type} but is of type #{type}"
    else
      "Expected #{model_class} to have property #{property}"
    end
  end

  failure_message_for_should_not do |model|
    model_class = model.is_a?(Class) ? model : model.class
    if @type
      type = model_class.properties.find{|f| f.name == property}.class
      "property #{property} should not be of type #{@type} but is of type #{type}"
    else
      "Expected #{model_class} to not have property #{property}"
    end
  end


end


# module DataMapper
#   module Matchers

#     class HaveProperty
#       def initialize(property)
#         @property = property.to_sym
#       end

#       def matches?(model)
#         model_class = model.is_a?(Class) ? model : model.class
#         model_class.properties.map(&:name).include? @property
#       end

#       def failure_message
#         "expected to have property #{@property}"
#       end

#       def negative_failure_message
#         "expected to not have property #{@property}"
#       end
      
#       def description
#         "has property #{@children}"
#       end
#     end


#     def have_property(name)
#       HaveProperty.new(name)
#     end

#   end
# end
