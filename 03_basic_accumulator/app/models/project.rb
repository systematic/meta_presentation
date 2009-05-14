class Project < ActiveRecord::Base
  TASKS = []
  
  def self.tasks
    Project::TASKS
  end
  
  def self.task(*args, &block)
    Project::TASKS << args.slice(0)
    define_method(*args) do |*inner_args|
      block.call(*inner_args)
    end
  end
  
  task :steal_underpants do
    "theft!"
  end
  
  task :dotdotdot do
    "..."
  end
  
  task :profit do
    "$$$$$$$"
  end
  
  task :bar do 
    "beer!"
  end
  
  task :test_task do 
    "test"
  end
end
