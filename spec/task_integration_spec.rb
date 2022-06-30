require "task"
require "task_list"

RSpec.describe "task integration" do
    it "adds task to the list" do
        task_list = TaskList.new
        task_1 = Task.new("Do the dishes")
        task_2 = Task.new("Wash the car")
        task_list.add(task_1)
        task_list.add(task_2)
        expect(task_list.all).to eq [task_1, task_2]
    end
end