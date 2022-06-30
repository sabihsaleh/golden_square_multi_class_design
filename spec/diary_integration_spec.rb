require "diary"
require "diary_entry"
require "diary_reader"
require "phone_number"

RSpec.describe " diary integration" do
    it "adds diary entry to a list" do
        diary = Diary.new
        entry_1 = DiaryEntry.new("my title", "my contents")
        entry_2 = DiaryEntry.new("my title two", "my contents two")
        diary.add(entry_1)
        diary.add(entry_2)
        expect(diary.entries).to eq [entry_1, entry_2]
    end
    describe " diary reading behaviour" do
        context " where the diary entry is perfect to read in time " do
            it "find the entry" do
                diary = Diary.new
                reader = DiaryReader.new(2, diary)
                entry_1 = DiaryEntry.new("title1", "one")
                entry_2 = DiaryEntry.new("title2", "one two")
                entry_3 = DiaryEntry.new("title3", "one two three")
                entry_4 = DiaryEntry.new("title4", "one two three four")
                entry_5 = DiaryEntry.new("title4", "one two three four five")
                diary.add(entry_1)
                diary.add(entry_2)
                diary.add(entry_3)
                diary.add(entry_4)
                diary.add(entry_5)
                expect(reader.find_most_readable_in_time(2)).to eq entry_4
            end
        end
        context "where the best entry is shorter than optimum" do
            it "finds that entry" do 
                diary = Diary.new
                reader = DiaryReader.new(2, diary)
                entry_1 = DiaryEntry.new("title1", "one")
                entry_2 = DiaryEntry.new("title2", "one two ")
                entry_3 = DiaryEntry.new("title3", "one two three")
                entry_5 = DiaryEntry.new("title4", "one two three four five")
                diary.add(entry_1)
                diary.add(entry_2)
                diary.add(entry_3)
                diary.add(entry_5)
                expect(reader.find_most_readable_in_time(2)).to eq entry_2
            end
        end
        context "where there is nothing readable in given time" do
            it "return nil" do
                diary = Diary.new
                reader = DiaryReader.new(2, diary)
                entry_1 = DiaryEntry.new("title4", "one two three four five")
                diary.add(entry_1)
                expect(reader.find_most_readable_in_time(2)).to eq nil
            end
        end
        context "where there is input" do
            it "returns nil" do
                diary = Diary.new
                reader = DiaryReader.new(2, diary)
                expect(reader.find_most_readable_in_time(2)).to eq nil
            end
        end
        context "where wpm is invalid" do
            it "fail" do
                    diary = Diary.new
                    expect { DiaryReader.new(0, diary) }.to raise_error  "WPM must be positive."
            end
        end
    end
    describe "phone number extraction behaviour" do
        it "construct phone number from all diary entries" do
            diary = Diary.new
            phone_book = PhoneNumberCrawler.new(diary)
            diary.add(DiaryEntry.new("title1", "my friend 07800000000 is cool"))
            diary.add(DiaryEntry.new("title2", "my friends 07800000000, 07800000001, and 07800000002 07800000002 are cool"))
            expect(phone_book.extract_numbers).to eq [
            "07800000000",
            "07800000001",
            "07800000002"
            ]
        end
        it "does not extract if the number is invalid" do
            diary = Diary.new
            phone_book = PhoneNumberCrawler.new(diary)
            diary.add(DiaryEntry.new("title1", "my friend 09800000000 is cool"))
            diary.add(DiaryEntry.new("title0", "my friend is cool"))
            diary.add(DiaryEntry.new("title2", "my friends 10800000000, 06800000001, and 05800000002 04800000002 are cool"))
            expect(phone_book.extract_numbers).to eq []
        end
    end
end