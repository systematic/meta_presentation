class Project < ActiveRecord::Base
  TASKS = ["steal_underpants", "dotdotdot", "profit"]
  
  def self.tasks
    Project::TASKS
  end
  
  def steal_underpants
    "theft!"
  end
  
  def dotdotdot
    "..."
  end
  
  def profit
    "$$$$$$$"
  end
end
