package app.strategies

import app.*

object IntCountingSortingStrategy : SortingStrategy<Int> {
    override fun sort(coll: Collection<Int>) = AscendingIntIterable(coll).toList()
}