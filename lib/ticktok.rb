# frozen_string_literal: true

require "ticktok/version"

module Ticktok
  class Timer
    attr_reader :total_time, :count

    def initialize
      @total_time = 0
      @count = 0
    end

    def add(elapsed)
      @total_time += elapsed
      @count += 1
    end

    def average
      return 0 if @count == 0
      @total_time / @count
    end
  end

  @timers = {}

  class << self
    def track(name)
      start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      result = yield if block_given?
      end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      elapsed = end_time - start_time

      @timers[name] ||= Timer.new
      @timers[name].add(elapsed)

      result
    end

    def timers
      @timers.transform_values(&:total_time)
    end

    def detailed_timers
      result = {}
      @timers.each do |name, timer|
        result[name] = {
          total: timer.total_time,
          count: timer.count,
          average: timer.average
        }
      end
      result
    end

    def reset
      @timers = {}
    end
  end
end