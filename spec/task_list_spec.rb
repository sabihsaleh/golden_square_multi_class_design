require "task_list"

RSpec.describe TaskList do
    it "initally has an empty list" do
        task_list =TaskList.new
        expect(task_list.all).to eq []
    end
end
