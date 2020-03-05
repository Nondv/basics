package app.ascendingIntIterable

import app.Counter
import app.IntMinMax

class AscendingIntIterator(numbers: Iterable<Int>) : Iterator<Int> {
    private val minMax = IntMinMax(numbers)
    private val counter = Counter(numbers)
    private var currentNumber = minMax.min
    private var currentNumberGiven = 0

    override fun hasNext() = currentNumber < minMax.max || currentNumberGiven < counter.count(currentNumber)

    override fun next(): Int {
        if(currentNumberGiven == counter.count(currentNumber)) {
            currentNumberGiven = 0
            currentNumber++
            while(counter.count(currentNumber) == 0)
                currentNumber++
        }

        currentNumberGiven++
        return currentNumber
    }
}