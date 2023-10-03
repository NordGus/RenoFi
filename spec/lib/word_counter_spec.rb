require './lib/word_counter'

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

    context "1. Lorem ipsum  , sample text !" do
      let(:text) { "1. Lorem ipsum  , sample text !" }

      it "should return the correct number of words" do
        expect(subject.call).to eq(4)
      end
    end

    context "can, canada" do
      let(:text) { "can, canada" }

      it "should return the correct number of words" do
        expect(subject.call).to eq(4)
      end
    end
  end
end