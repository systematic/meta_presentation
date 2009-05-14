class Project < ActiveRecord::Base  
  TASKS = []
  include TaskMaster
  include OtherTasks
  include TestTask
  
  def self.tasks
    Project::TASKS
  end
    
end
