def sleep_sort(array, multiplier)
  result = []
  threads = array.map do |x|
    Thread.new do
      sleep(x * multiplier)
      result.push(x)
    end
  end
  threads.each(&:join)
  result
end



require "minitest/autorun"

module Tests
  def test_random_100
    array = (1..100).to_a
    assert_equal(array, subject(array.shuffle))
  end

  def test_random_10
    array = (1..10).to_a
    assert_equal(array, subject(array.shuffle))
  end
end


#
# both fail
#
class TestMilliseconds < Minitest::Test
  include Tests

  def subject(array)
    sleep_sort(array, 0.001)
  end
end

class TestCentiseconds < Minitest::Test
  include Tests

  def subject(array)
    sleep_sort(array, 0.01)
  end
end

class TestDeciseconds < Minitest::Test
  include Tests

  def subject(array)
    sleep_sort(array, 0.1)
  end
end
