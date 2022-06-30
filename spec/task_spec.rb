require "task"

RSpec.describe  Task do
    it "construct" do
        task = Task.new("Do the dishes")
        expect(task.title).to eq "Do the Dishes"
    end
end
