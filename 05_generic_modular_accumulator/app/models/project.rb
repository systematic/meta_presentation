class Project < ActiveRecord::Base  
  include OtherTasks
  include TestTask
end
