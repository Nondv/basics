package app.strategies

import app.*
import app.oneToOneRelations.IntIdentityRelation
import app.strategies.countingSortingStrategy.AscendingIterable

object IntCountingSortingStrategy : SortingStrategy<Int> {
    private val innerStrategy = CountingSortingStrategy(IntIdentityRelation)

    override fun sort(coll: Collection<Int>) = innerStrategy.sort(coll)
}