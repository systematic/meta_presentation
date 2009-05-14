module TaskMaster
  def self.included(klass)
    klass.extend(ClassMethods)
  end
  
  module ClassMethods

    # When the 'task' method is called, it's going to be looking for a place to accumulate the newly
    # defined tasks. Since this is extra meta, we don't have access to the Project accumulator so we stow
    # them on the module until we can get access to Project.
    attr_accessor :tasks    
    
    # Defines 'task' method. This is the method that gets called when you call 'task' in each of the Task modules.
    def task(*args, &block)
      
      # puts the task we are currently defining into the Task module accumulator
      self.tasks ||= []
      self.tasks << args[0]
      
      # Things needing to be defined on the parent class (e.g. Project) go here.
      # 'self' here is the ClassMethods module we dynamically define below, making
      # 'self.parent' the Task module that included RomTask
      # 'o' is Project
      new_class_methods_for_task_module = lambda do
        attr_accessor :tasks
        def self.extend_object(o)
          super # have to call super to make sure all the usual self.included magic happens
          o.tasks ||= []
          o.tasks += self.parent.tasks
        end
      end
      
      # We need to define ClassMethods on the Task module so that the new_class_methods_for_task_module created above gets added to
      # Project class when 'self.included' is called by Project, which occurs as a result of including this Task module.
      #
      # Let me say that again a different way. Project includes SomeTask includes TaskMaster. Each of these call 
      # self.included which gives us the opportunity we need. We want the ClassMethods and 'self.included' in SomeTask to put all
      # the tasks in SomeTask into the Project task accumulator. However, we don't know what the tasks are going to be
      # until evaluation time, so we define/update ClassMethods on the fly right here.
      module_eval do
        if self.const_defined? :ClassMethods
          self.const_get(:ClassMethods).module_eval(&new_class_methods_for_task_module)
        else
          self.const_set(:ClassMethods, Module.new(&new_class_methods_for_task_module))
        end
      end
      
      # This defines the method that actually does the work.
      # If you make a task like
      #
      # task :foo do
      #   "bar"
      # end
      #
      # this is where we define `foo` as an instance method of Project.
      # We've changed to using instance_exec here from our previous block.call implementation
      # so that we're executing the method body in the context of Project instead of the Task module.
      module_eval do
        define_method(*args) do |*inner_args|
          task_name = args[0]
          instance_exec(*inner_args, &block)
        end
      end
      
      # define the 'self.included' method so the above defined ClassMethods puts new_class_methods_for_task_module on Project.
      module_eval do
        def self.included(klass)
          klass.extend self.const_get(:ClassMethods)
        end
      end
      
    end
  end
  
  # Puts the TaskMaster ClassMethods on SomeTask 
  def self.included(klass)
    klass.extend ClassMethods
  end
end
