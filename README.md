# Ticktok

A simple Ruby gem for tracking execution time of code blocks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ticktok'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install ticktok
```

## Usage

```ruby
require 'ticktok'

# Track execution time of a code block with a name
Ticktok.track(:operation_1) do
  # Your code here
  sleep(1)
end

# Track another operation
Ticktok.track(:operation_2) do
  # Some other code
  sleep(0.5)
end

# Track the first operation again
Ticktok.track(:operation_1) do
  # More code
  sleep(1.5)
end

# Get all timers with total times
Ticktok.timers
# => {:operation_1=>2.5, :operation_2=>0.5}

# Get detailed stats for all timers
Ticktok.detailed_timers
# => {:operation_1=>{:total=>2.5, :count=>2, :average=>1.25}, :operation_2=>{:total=>0.5, :count=>1, :average=>0.5}}

# Reset all timers
Ticktok.reset
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mumenmusa/ticktok.

## License

The gem is available as open source under the terms of the MIT License.