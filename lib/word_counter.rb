require 'trie'

class WordCounter
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def call
    Trie.new.insert_words(words: text.split(" ")).word_count
  end

  private

end