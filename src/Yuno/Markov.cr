module Yuno
  class Chain
    START_TOKEN = "__start__"
    END_TOKEN   = "__end__"

    @data = Hash(String, Hash(String, Int32)).new do |h, k|
      h[k] = Hash(String, Int32).new { |h, k| h[k] = 0 }
    end

    def initialize
    end

    def <<(content)
      push content
    end

    def push(content)
      last = START_TOKEN
      content.split.each do |word|
        add_member last, word
        last = word
      end
      add_member last, END_TOKEN
    end

    def add_member(last, word)
      @data[last][word] += 1
    end

    def generate
      last = START_TOKEN
      total = [] of String
      while last != END_TOKEN
        choices = [] of String
        @data[last].each do |key, val|
          val.times { choices << key }
        end
        chosen = choices.sample

        total << chosen unless chosen == END_TOKEN
        last = chosen
      end
      total.join " "
    end
  end
end
