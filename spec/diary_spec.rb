require "diary"

RSpec.describe Diary do
    it "initially has an empty list" do
        diary = Diary.new
        expect(diary.entries).to eq []
    end
end

