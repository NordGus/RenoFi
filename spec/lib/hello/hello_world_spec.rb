require './spec/spec_helper'
require './lib/hello'

include Hello

describe "#hello_world" do
  it "should salute the world" do
    expect { hello_world }.to output(a_string_including("hello world")).to_stdout_from_any_process
  end
end