#
# Classic solution
#
def b_search(array, value, left_i = 0, right_i = array.size - 1)
  return nil if left_i > right_i

  mid_i = left_i + (right_i - left_i) / 2
  return mid_i if array[mid_i] == value

  if array[mid_i] < value
    b_search(array, value, mid_i + 1, right_i)
  else
    b_search(array, value, left_i, mid_i - 1)
  end
end







require "minitest/autorun"

module Tests
  def test_empty
    assert_nil(subject([], 1))
    assert_nil(subject([], nil))
  end

  def test_one
    assert_equal(0, subject([1], 1))
    assert_nil(subject([2], 1))
    assert_nil(subject([2], 100))
  end

  def test_two
    assert_equal(0, subject([1, 2], 1))
    assert_equal(1, subject([3, 4], 4))
    assert_nil(subject([1, 2], 3))
  end

  def test_three
    assert_equal(0, subject([1, 2, 3], 1))
    assert_equal(1, subject([4, 5, 6], 5))
    assert_equal(2, subject([7, 8, 9], 9))

    assert_nil(subject([7, 8, 9], 1))
    assert_nil(subject([7, 8, 9], 100))
  end
end

class TestClassic < Minitest::Test
  include Tests

  def subject(array, value)
    b_search(array, value)
  end
end
