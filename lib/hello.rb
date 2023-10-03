#!/usr/bin/env ruby

# Dependencies

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rspec'
end

# Application
class WordCounter
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def call
    text.split(" ").select { |word| /\p{L}/ =~ word }.size
  end

  private
  class Trie
    def initialize
      @root = Node.new("", is_end: false)
    end

    private

    attr_reader :root

    class Node
      attr_reader :letter, :children, :is_end

      def initialize(letter, is_end:)
        @letter = letter
        @is_end = is_end
        @children = Array.new
      end


    end
  end
end

# Tests
RSpec.describe WordCounter do
  subject { described_class.new(text) }

  describe "#call" do
    context "hello world" do
      let(:text) { "hello world" }

      it "should return the correct number of words" do
        expect(subject.call).to eq(2)
      end
    end

    context "hello world ?" do
      let(:text) { "hello world ?" }

      it "should return the correct number of words" do
        expect(subject.call).to eq(2)
      end
    end

    context "1. Lorem ipsum , sample text !" do
      let(:text) { "1. Lorem ipsum , sample text !" }

      it "should return the correct number of words" do
        expect(subject.call).to eq(4)
      end
    end
  end
end

RSpec::Core::Runner.invoke