class Project < ActiveRecord::Base
  TASKS = []
  
  def self.tasks
    Project::TASKS
  end
  
  def self.method_added(method)
    if method.to_s =~ /task/
      Project::TASKS << method.to_s
    end
  end
  
  def task_steal_underpants
    "theft!"
  end
  
  def task_dotdotdot
    "..."
  end
  
  def task_profit
    "$$$$$$$"
  end
  
  def task_bar
    "beer!"
  end
end
