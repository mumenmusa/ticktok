# frozen_string_literal: true

RSpec.describe Ticktok do
  it "has a version number" do
    expect(Ticktok::VERSION).not_to be nil
  end

  describe ".track" do
    it "returns the result of the block" do
      result = Ticktok.track(:test) { "result" }
      expect(result).to eq("result")
    end

    it "tracks execution time" do
      Ticktok.track(:test) { sleep(0.1) }
      expect(Ticktok.timers[:test]).to be_within(0.05).of(0.1)
    end

    it "accumulates time for the same name" do
      Ticktok.track(:test) { sleep(0.1) }
      Ticktok.track(:test) { sleep(0.1) }
      expect(Ticktok.timers[:test]).to be_within(0.05).of(0.2)
    end

    it "increments count for the same name" do
      Ticktok.track(:test) { sleep(0.1) }
      Ticktok.track(:test) { sleep(0.1) }
      expect(Ticktok.detailed_timers[:test][:count]).to eq(2)
    end

    it "handles multiple timer names" do
      Ticktok.track(:test1) { sleep(0.1) }
      Ticktok.track(:test2) { sleep(0.2) }
      
      expect(Ticktok.timers.keys).to match_array([:test1, :test2])
      expect(Ticktok.timers[:test1]).to be_within(0.05).of(0.1)
      expect(Ticktok.timers[:test2]).to be_within(0.05).of(0.2)
    end
  end

  describe ".timers" do
    it "returns a hash of timer names and total times" do
      Ticktok.track(:test1) { sleep(0.1) }
      Ticktok.track(:test2) { sleep(0.2) }
      
      timers = Ticktok.timers
      expect(timers).to be_a(Hash)
      expect(timers.keys).to match_array([:test1, :test2])
    end
  end

  describe ".detailed_timers" do
    it "returns detailed information for each timer" do
      Ticktok.track(:test) { sleep(0.1) }
      Ticktok.track(:test) { sleep(0.3) }
      
      detailed = Ticktok.detailed_timers[:test]
      expect(detailed[:total]).to be_within(0.05).of(0.4)
      expect(detailed[:count]).to eq(2)
      expect(detailed[:average]).to be_within(0.05).of(0.2)
    end
  end

  describe ".reset" do
    it "clears all timers" do
      Ticktok.track(:test) { sleep(0.1) }
      expect(Ticktok.timers).not_to be_empty
      
      Ticktok.reset
      expect(Ticktok.timers).to be_empty
    end
  end
end