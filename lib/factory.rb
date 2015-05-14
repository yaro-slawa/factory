require "factory/version"

class Factory
  def self.new(*args, &block)
    
    raise ArgumentError, "wrong number of arguments" if args.length == 0
    
    Class.new do

      args.each { |arg| attr_accessor arg}
      define_method :initialize do |*params|
      	raise ArgumentError, "wrong number of arguments" unless params.length == args.length
      	(0...params.length).each { |i| instance_variable_set("@#{args[i]}", params[i]) }
      end

      define_method :[] do |param|
      	if param.is_a?(String) || param.is_a?(Symbol)
      	  instance_variable_get("@#{param}") 
        elsif param.is_a?(Fixnum)
          instance_variable_get(instance_variables[param])
        end
      end

      define_method :inspect do
      	"<struct #{self.class} " + instance_variables.collect{ |var| "#{var.to_s[/[a-zA-Z]+/]}=\"#{instance_variable_get(var)}\""}.join(", ") + ">"
      end

      class_eval(&block) if block_given?
    end
  end
end