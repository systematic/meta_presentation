# A Meta Programming Presentation

Last night (May 13, 2009), I gave a short presentation on meta-programming based on watching some code evolve in a
project I worked on last year that involved a lot of such shenanigans. Each of the folders in this repository represents
one phase of the project. Most of the action is in app/models/project.rb and eventually in lib/task_master.rb. Below is
an description of each phase.

# 01_hardcode_tastic

This is the starting point. It's just a super basic application. The projects show page (i.e. project/1) list the tasks
that are hardcoded in Project::TASKS along with the output those methods. It's lame, so we start improving it. 

# 02_method_added

Looking in the project model, we do away with the hardcoding and switch to using method_added so that any method on
Project with the work "task" in it gets added to Project::TASKS automatically and shows up in the interface.

# 03_basic_accumulator

Having naming requirements for methods is lame, so we switch to using a basic task accumulator method and start defining
our tasks using syntax like

task :foo do
  "bar"
end

# 04_modular_accumulator_with_constant_hardcoding

The project.rb file is getting a little large - imagine these tasks actually doing real stuff - so we move the `task`
method and the various tasks into modules. We still have the Project and Project::TASKS constants hard coded into the
modules, so it's not really very generic.

# 05_generic_modular_accumulator

And, of course, we want it to be generic. We change the syntax in project.rb so it just includes the TestTask and
OtherTasks modules and make them do all the magic: automatically making a class accessor on project and accumulating the
relevant tasks into it as they are included. 
