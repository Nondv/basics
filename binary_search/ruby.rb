#
# Classic solution
#

def b_search(array, value)
  left_i = 0
  right_i = array.size - 1

  while left_i <= right_i
    mid_i = left_i + (right_i - left_i) / 2
    return mid_i if array[mid_i] == value

    if array[mid_i] < value
      left_i = mid_i + 1
    else
      right_i = mid_i - 1
    end
  end
  nil
end

def rec_b_search(array, value, left_i = 0, right_i = array.size - 1)
  return nil if left_i > right_i

  mid_i = left_i + (right_i - left_i) / 2
  return mid_i if array[mid_i] == value

  if array[mid_i] < value
    rec_b_search(array, value, mid_i + 1, right_i)
  else
    rec_b_search(array, value, left_i, mid_i - 1)
  end
end


#
# Object-oriented (kind of) immutable solution
#

class ArraySlice
  def initialize(array, first_index, last_index)
    self.array = array
    self.first_index = first_index
    self.last_index = last_index
  end

  def size
    [0, last_index - first_index + 1].max
  end

  def [](relative_index)
    return nil if out_of_bounds?(relative_index)
    array[actual_index(relative_index)]
  end

  def to_a
    array[first_index..last_index]
  end

  def slice(relative_a, relative_b)
    ArraySlice.new(array, actual_index(relative_a), actual_index(relative_b))
  end

  def b_search(value)
    return nil if size.zero?

    relative_mid = size / 2

    return actual_index(relative_mid) if self[relative_mid] == value

    next_slice = if self[relative_mid] < value
                   slice(relative_mid + 1, size - 1)
                 else
                   slice(0, relative_mid - 1)
                 end

    next_slice.b_search(value)
  end

  private

  attr_accessor :array, :first_index, :last_index

  def actual_index(relative_index)
    first_index + relative_index
  end

  def out_of_bounds?(relative_index)
    actual = actual_index(relative_index)
    actual < first_index || actual > last_index
  end
end

#
# Code golf
#
S=->(a,v,l=0,r=a.size-1){
l>r&&next
m=(l+r)/2
a[m]==v ? m : a[m]<v ? S[a,v,m+1,r] : S[a,v,l,m-1]
}








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

class TestRecClassic < Minitest::Test
  include Tests

  def subject(array, value)
    rec_b_search(array, value)
  end
end

class TestOOP < Minitest::Test
  include Tests

  def subject(array, value)
    ArraySlice.new(array, 0, array.size - 1).b_search(value)
  end
end

class TestCodeGolf < Minitest::Test
  include Tests

  def subject(array, value)
    S[array, value]
  end
end
