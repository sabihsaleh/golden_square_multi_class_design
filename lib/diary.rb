class Diary
    def initialize
        @entries = []
    end
    def add(entry)
        @entries << entry
    end   
  
    def entries
      return @entries # return instance of DiaryEntriers
    end
  end