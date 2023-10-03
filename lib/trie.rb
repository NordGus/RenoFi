class Trie
  def initialize
    @root = Node.new("")
  end

  def insert_words(words: [])
    words.each { |word| insert_word(word) }

    self
  end

  def word_count
    count_words(root)
  end

  private

  attr_reader :root

  def insert_word(word = "")
    return if word.match(/\p{L}/).nil?

    test = ""

    current = root

    word.each_char do |letter|
      next if letter.match(/\p{L}/).nil?
      current.add_child(letter) unless current.has_child?(letter)
      current = current.get_child(letter)
      test << letter
    end

    puts test

    current.is_end = true

    current
  end

  def count_words(node, count: 0)
    return count + 1 if node.children.empty? # if the node node is a leaf it means is the end of a word

    sum = count

    node.children.each do |_, child|
      sum += count_words(child, count: node.is_end ? count + 1 : count) # if the node has children and is marked as is_end it means there's more words in the data structure
    end

    sum
  end

  class Node
    attr_reader :letter, :children
    attr_accessor :is_end

    def initialize(letter)
      @letter = letter
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
      children[letter] = Node.new(letter)
    end
  end
end