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
