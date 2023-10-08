class WordCounter
  attr_reader :text

  def initialize(text)
    @text = text
    @root = Letter.new("")
  end

  def call
    text.split(" ").each { |word| insert_word(word) } if root.children.empty?

    word_count(root)
  end

  private

  attr_reader :root

  def insert_word(word = "")
    return root if word == ""

    current = root

    word.each_char do |letter|
      current.add_child(letter) unless current.has_child?(letter)
      current = current.get_child(letter)
    end

    current.is_end = true
    current
  end

  def word_count(letter, count: 0)
    return count + 1 if letter.value =~ /\p{L}/ && letter.children.empty?
    return count if letter.children.empty?

    sum = count

    letter.children.each do |_, child|
      if letter.value =~ /\p{L}/ && %w[, . : ; ? !].include?(child.value) && child.is_end && !letter.is_end # punctuation at the end
        sum += word_count(child, count: count + 1)
      elsif letter.value =~ /\p{L}/ && letter.is_end
        sum += word_count(child, count: count + 1)
      else
        sum += word_count(child, count: count)
      end
    end

    sum
  end

  class Letter
    attr_reader :value, :children
    attr_accessor :is_end

    def initialize(letter)
      @value = letter
      @is_end = false
      @children = Hash.new
    end

    def has_child?(letter)
      !children[letter].nil?
    end

    def get_child(letter)
      children[letter]
    end

    def add_child(letter)
      children[letter] = Letter.new(letter)
    end
  end
end