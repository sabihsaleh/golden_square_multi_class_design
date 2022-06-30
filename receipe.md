# Diary Multi-Class Planned Design Recipe

## 1. Describe the Problem

> As a user
> So that I can record my experiences
> I want to keep a regular diary

> As a user
> So that I can reflect on my experiences
> I want to read my past diary entries

> As a user
> So that I can reflect on my experiences in my busy day
> I want to select diary entries to read based on how much time I have and my reading speed

> As a user
> So that I can keep track of my tasks
> I want to keep a todo list along with my diary

> As a user
> So that I can keep track of my contacts
> I want to see a list of all of the mobile phone numbers in all my diary entries

## 2. Design the Class System

  ruby

class Diary
  def add(entry)
  end   

  def entries
    #return list of DiaryEntries
  end
end

  class DiaryEntry    def initialize(title, contents) # title and contents are both string
    end

    def title
    # return title 
    end

    def contents
    # return contents
    end
  end

  class PhoneNumberCrawler

    def initialize(diary) #diary is an instance of Diary
    end

    def extract_numbers
    # Return a list of strings representing phone number 
    # gathered across all diary entries
    end
  end

  class DiaryReady

    def initialize(wpm, diary)
      # wpm is a number representing how many words the reader can read
      # in one minute
      # diary is an instance of Diary
    end
    def find_most_readable_in_time(time)
    # Returns the DiaryEntry, corresponding to the entry with 
    # the longest contents that is still readable within the time
    # based on wpm specified earlier 
    end
  end

  class TaskList
    def add(task) # task is an instance of task
    end
    
    def all
    # Returns a list of tasks
    end

    class Task

      def initialize(title) # title is a string
      end

      def title
      # Returns the title as a string
      end
    end


## 3. Create Examples as Integration Tests

--ruby

# > As a user
# > So that I can record my experiences
# > I want to keep a regular diary

# > As a user
# > So that I can reflect on my experiences
# > I want to read my past diary entries

# 1
diary = Diary.new
entry_1 = DiaryEntry.new("my title", "my contents")
entry_2 = DiaryEntry.new("my title two", "my contents two")
diary.add(entry_1)
diary.add(entry_2)
expect(diary.entries).to eq [entry_1, entry_2]

# > As a user
# > So that I can reflect on my experiences in my busy day
# > I want to select diary entries to read based on how much time I have and my reading speed

# 2 fits exactly
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

# 3 -  does not fit exactly
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
expect(reader.find_most_readable_in_time(2)).to eq entry_3

# 4 -  nothing readable 
diary = Diary.new
reader = DiaryReader.new(2, diary)
entry_1 = DiaryEntry.new("title4", "one two three four five")
diary.add(entry_1)
expect(reader.find_most_readable_in_time(2)).to eq nil

# 5 nothing at all

diary = Diary.new
reader = DiaryReader.new(2, diary)
expect(reader.find_most_readable_in_time(2)).to eq nil

# 6 wpm invalid

diary = Diary.new
reader = DiaryReader.new(2, diary) # fail with "WPM must be positive."

# > As a user
# > So that I can keep track of my tasks
# > I want to keep a todo list along with my diary

# 7
task_list = TaskList.new
task_1 = Task.new("Do the dishes")
task_2 = Task.new("Wash the car")
task_list.add(task_1)
task_list.add(task_2)
expect(task_list).to eq (task_1, task_2)


# > As a user
# > So that I can keep track of my contacts
# > I want to see a list of all of the mobile phone numbers in all my diary entries

# 8
diary = Diary.new
phone_book = PhoneNumberCrawler.new(diary)
diary.add(DiaryEntry.new("title1", "my friend 07800000000 is cool"))
diary.add(DiaryEntry.new("title2", "my friends 07800000000, 07800000001, and 07800000002 07800000002 are cool"))
expect(phone_book.extract_numbers).to eq [
  "07800000000"
  "07800000001"
  "07800000002"
]

