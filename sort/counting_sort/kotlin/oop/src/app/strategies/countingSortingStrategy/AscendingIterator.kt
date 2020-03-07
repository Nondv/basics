package app.strategies.countingSortingStrategy

import app.Counter
import app.IntMinMax
import app.OneToOneRelation

class AscendingIterator<T>(
    private val coll: Collection<T>,
    private val objToIntRelation: OneToOneRelation<T, Int>
) : Iterator<T> {

    private val minMax = IntMinMax(coll.map { obj -> objToIntRelation.y(obj) })
    private val counter = Counter(coll)
    private var currentInt = minMax.min
    private var currentGiven = 0
    private var totalGiven = 0

    override fun hasNext() = totalGiven < coll.size
    override fun next(): T {
        while(currentLeftToGive() == 0)
            switchToNextObj()

        val result = currentObj()
        totalGiven++
        currentGiven++
        return result
    }

    private fun switchToNextObj() {
        currentInt++
        currentGiven = 0
    }
    private fun currentObj() = objToIntRelation.x(currentInt)
    private fun currentLeftToGive() = counter.count(currentObj()) - currentGiven
}