package app.strategies

import app.strategies.countingSortingStrategy.AscendingIterable
import app.OneToOneRelation
import app.SortingStrategy

class CountingSortingStrategy<T>(
    private val objToIntRelation: OneToOneRelation<T, Int>
) : SortingStrategy<T> {

    override fun sort(coll: Collection<T>) =
        AscendingIterable(coll, objToIntRelation).toList()
}