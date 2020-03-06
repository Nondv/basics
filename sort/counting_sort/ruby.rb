def classic(array)
  counters = Array.new(array.max + 1, 0)
  array.each { |e| counters[e] += 1 }

  result = Array.new(array.size)

  i = 0
  counters.size.times do |number|
    counters[number].times do
      result[i] = number
      i += 1
    end
  end

  result
end

def classic2(array)
  counters = Array.new(array.max + 1, 0)
  array.each { |e| counters[e] += 1 }

  result = Array.new(array.size)

  i = 0
  number = 0
  while i < result.size
    j = 0
    while j < counters[number]
      result[i] = number
      i += 1
      j += 1
    end
    number += 1
  end

  result
end




require "minitest/autorun"

module Tests
  def test_random
    random = ->(*_) { (rand * 100).to_i }
    10.times do
      array = Array.new(1000, &random)
      assert_equal(array.sort, subject(array))
    end
  end
end



class TestClassic < Minitest::Test
  include Tests

  def subject(array)
    classic(array)
  end
end

class TestClassic2 < Minitest::Test
  include Tests

  def subject(array)
    classic2(array)
  end
end


require 'benchmark'

puts '[Benchmark] 10M elements, MAX = 10'
array = Array.new(10_000_000) { (rand * 10).to_i }

Benchmark.bm(15) do |b|
  b.report('#classic') { classic(array) }
  b.report('#classic2') { classic2(array) }
  b.report('Array#sort') { array.sort }
end

puts '[Benchmark] 10M elements, MAX = 100'
array = Array.new(10_000_000) { (rand * 100).to_i }

Benchmark.bm(15) do |b|
  b.report('#classic') { classic(array) }
  b.report('#classic2') { classic2(array) }
  b.report('Array#sort') { array.sort }
end

puts nil, nil, '[Benchmark] 10M elements, MAX = 1M'
array = Array.new(10_000_000) { (rand * 1_000_000).to_i }

Benchmark.bm(15) do |b|
  b.report('#classic') { classic(array) }
  b.report('#classic2') { classic2(array) }
  b.report('Array#sort') { array.sort }
end

puts nil, nil
