def classic(array)
  array = array.clone

  array.size.times do |i|
    (1...array.size - i).each do |j|
      if array[j - 1] > array[j]
        array[j], array[j - 1] = array[j - 1], array[j]
      end
    end
  end

  array
end

def shaker(array)
  array = array.clone

  left = 0
  right = array.size - 1
  until left > right
    swap_happened = false
    ((left + 1)...array.size).each do |i|
      if array[i - 1] > array[i]
        array[i - 1], array[i] = array[i], array[i - 1]
        swap_happened = true
      else
        left = i unless swap_happened
      end
    end

    swap_happened = false
    (0..(right - 1)).reverse_each do |i|
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        swap_happened = true
      else
        right = i unless swap_happened
      end
    end
  end

  array
end

def selection(array)
  array = array.clone

  (0...array.size).each do |i|
    index_of_min = i
    (i...array.size).each do |j|
      index_of_min = j if array[j] < array[index_of_min]
    end
    array[i], array[index_of_min] = array[index_of_min], array[i]
  end

  array
end





require "minitest/autorun"

module Tests
  def test_random
    array = (1..100).to_a
    100.times do
      assert_equal(array, subject(array.shuffle))
    end
  end
end

class TestClassic < Minitest::Test
  include Tests

  def subject(array)
    classic(array)
  end
end

class TestShaker < Minitest::Test
  include Tests

  def subject(array)
    shaker(array)
  end
end


class TestSelection < Minitest::Test
  include Tests

  def subject(array)
    selection(array)
  end
end
