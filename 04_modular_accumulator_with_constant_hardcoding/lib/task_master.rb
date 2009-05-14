module TaskMaster
  def self.included(klass)
    klass.extend(ClassMethods)
  end
  
  module ClassMethods
    def task(*args, &block)
      Project::TASKS << args.slice(0)
      define_method(*args) do |*inner_args|
        block.call(*inner_args)
      end
    end
  end
end
