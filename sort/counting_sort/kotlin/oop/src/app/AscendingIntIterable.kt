package app

import app.ascendingIntIterable.AscendingIntIterator

class AscendingIntIterable(private val numbers: Iterable<Int>) : Iterable<Int> {
    override fun iterator() = AscendingIntIterator(numbers)
}