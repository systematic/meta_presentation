module CrazyTask
  module ClassMethods
    
    attr_accessor :tasks
    
    def task(*args, &block)
      
      self.tasks ||= []
      self.tasks << args[0]
      
      new_methods_block = lambda do
        attr_accessor :tasks
        def self.extend_object(o)
          super
          o.tasks ||= []
          o.tasks += self.parent.tasks
        end
      end
      
      module_eval do
        if self.const_defined?(:ClassMethods)
          self.const_get(:ClassMethods).module_eval(&new_methods_block)
        else
          self.const_set(:ClassMethods, Module.new(&new_methods_block))
        end 
      end
      
      
      # define the actual task method in the Task module so it will appear on project
      module_eval do 
        define_method(*args) do |*inner_args|
          task_name = args[0]
          instance_exec(*inner_args, &block)
          true
        end
      end
      
      
      # include ClassMethods on Project
      module_eval do 
        def self.included(klass)
          klass.extend(self.const_get(:ClassMethods))
          
        end 
      end
    end
  end
  
  def self.included(klass)
    klass.extend(ClassMethods)
  end
  

end
