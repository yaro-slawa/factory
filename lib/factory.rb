require "factory/version"

class Factory
  def self.new(*args, &block)
    
    raise ArgumentError, "wrong number of arguments" if args.length == 0
    
    Class.new do

      define_method :initialize do |*params|
      	raise ArgumentError, "wrong number of arguments" unless params.length == args.length
      	(0...params.length).each do |i| 
      	  instance_variable_set("@#{args[i]}", params[i]) 
      	  self.class.send(:attr_accessor, args[i])
      	end
      end

      self.class_eval(&block) if block_given?
    end
  end
end