#Implement all parts of this assignment within (this) module2_assignment2.rb file


#Implement a class called LineAnalyzer.
class LineAnalyzer

  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(line, line_number)
    @highest_wf_count = 0
    @highest_wf_words = []
    @content = line
    @line_number = line_number
    calculate_word_frequency(@content, @line_number)
  end
  
  def calculate_word_frequency(content, line_number)
    content_arr = content.split(' ')
    words = []
    content_arr.each do |word|
      current_w_count = content_arr.count(word)
      unless words.include?(word)
        if current_w_count > @highest_wf_count then
          @highest_wf_count = current_w_count
        end
        words.push(word)
      end
    end
    words.each do |word|
      if content_arr.count(word) == @highest_wf_count then
        @highest_wf_words.push(word)        
      end
    end
  end
end
# TESTING of LineAnalizer class ######################################
# line = LineAnalyzer.new('How How much wood would a wood chuck', 0)
# line = LineAnalyzer.new('Will it work maybe it will work do you think it will it will', 1)
######################################################################


#  Implement a class called Solution. 
class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
    @highest_count_across_lines = nil
    @highest_count_words_across_lines = nil
  end

  def analyze_file
    text = File.open("test.txt", "r").read
    # text.gsub!(/\r\n?/, "\n")
    line_num = 0
    text.each_line do |line|
      line = line.downcase()
      @analyzers.push(LineAnalyzer.new(line, line_num += 1))
    end
  end
  
  def calculate_line_with_highest_frequency
    @highest_count_across_lines = 0
    @analyzers.each do |analyzer|
      if analyzer.highest_wf_count > @highest_count_across_lines then
        @highest_count_across_lines = analyzer.highest_wf_count
      end
    end
    @highest_count_words_across_lines = []
    @analyzers.each do |analyzer|
      if analyzer.highest_wf_count == @highest_count_across_lines then
        @highest_count_words_across_lines.push(analyzer)
      end
    end
    # p @highest_count_across_lines
    # p @highest_count_words_across_lines
  end

  def print_highest_word_frequency_across_lines
    puts 'The following words have the highest word frequency per line:'
      @highest_count_words_across_lines.each do |analyzer|
        puts("#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})")
      end
  end

end

# TESTING of Solution class ##########################################
# solution = Solution.new()
# solution.analyze_file()
# solution.calculate_line_with_highest_frequency()
# p solution.highest_count_across_lines()
# p solution.highest_count_words_across_lines()
# solution.print_highest_word_frequency_across_lines()
######################################################################