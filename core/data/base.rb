module Data
  module Base
    def self.included(base)
      base.instance_exec do
        define_method(:records) do |&block|
          database.perform do |data|
            block.call(data.table(table))
          end
        end
      end
    end
  end
end
  