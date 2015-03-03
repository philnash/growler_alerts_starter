require "./spec/spec_helper"
require "./lib/cellar"

describe Cellar do
  before :all do
    @redis = Redis.new
  end

  after :all do
    @redis.del "growler_test:current"
    @redis.del "growler_test:previous"
  end

  it "initializes with a prefix and an instance of Redis" do
    cellar = Cellar.new("growler_test", @redis)
    cellar.must_be_instance_of Cellar
  end

  it "initializes with just a prefix" do
    cellar = Cellar.new("growler_test")
    cellar.must_be_instance_of Cellar
  end

  it "requires a prefix" do
    lambda { Cellar.new }.must_raise ArgumentError
  end

  describe "instance" do
    before :all do
      @beers = ["Beer 1", "Beer 2"]
      @more_beers = ["Beer 2", "Beer 3"]
      @cellar = Cellar.new("growler_test", @redis)
    end

    it "starts with an empty array of current beers" do
      @cellar.current_beers.must_equal []
    end

    it "starts with an empty array of previous beers" do
      @cellar.previous_beers.must_equal []
    end

    it "adds beers to current_beers" do
      @cellar.current_beers = @beers
      @cellar.current_beers.sort.must_equal @beers
    end

    it "only adds new beers to current_beers" do
      @cellar.current_beers = @beers
      @cellar.current_beers = @more_beers
      @cellar.current_beers.sort.must_equal @more_beers
    end

    it "kicks old beers to previous_beers" do
      @cellar.current_beers = @beers
      @cellar.current_beers = @more_beers
      @cellar.previous_beers.must_equal ["Beer 1"]
    end

    it "clears the cellar" do
      @cellar.current_beers = @beers
      @cellar.current_beers = @more_beers
      @cellar.clear
      @cellar.current_beers.must_equal []
      @cellar.previous_beers.must_equal []
    end
  end
end
