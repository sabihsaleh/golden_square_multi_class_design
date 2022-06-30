class DiaryReader

    def initialize(wpm, diary)
      # wpm is a number representing how many words the reader can read
      # in one minute
      # diary is an instance of Diary
      fail "WPM must be positive." unless wpm.positive?
      @wpm = wpm
      @diary = diary
    end
    def find_most_readable_in_time(time)
        # Returns the DiaryEntry, corresponding to the entry with 
        # the longest contents that is still readable within the time
        # based on wpm specified earlier 
        return readable_entries(time).max_by do |entry|
            count_words(entry)
        end
    end
    private

    def readable_entries(time)
        return @diary.entries.reject do |entry|
            calculate_reading_time(entry) > time
        end
    end

    def calculate_reading_time(entry)
        return (count_words(entry)/ @wpm.to_f).ceil
    end
    def count_words(entry)
        return 0 if entry.contents.empty?
        return entry.contents.count(" ") + 1
    end
end
