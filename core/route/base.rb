module Route
  module Base
    def self.included(base)
      base.send :private_class_method, :new

      def base.define(*args)
        @define ||= new(*args)
      end
  
      def base.instance
        @define
      end
  
      def base.generate(*args, &block)
        define(*args)
        @define.instance_exec(&block)
      end
    end
  end
end