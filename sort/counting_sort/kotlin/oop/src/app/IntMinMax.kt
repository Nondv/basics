package app

class IntMinMax(numbers: Iterable<Int>) {
    val min = numbers.reduce { a, e -> if (a < e) a else e } ?: 0
    val max = numbers.reduce { a, e -> if (a > e) a else e } ?: 0
}