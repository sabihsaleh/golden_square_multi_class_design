class TaskList
    def initialize 
        @tasks = []
    end
    def add(task) # task is an instance of task
        @tasks << task 
     end
    
    def all
    # Returns a list of tasks
    return @tasks
    end
end 