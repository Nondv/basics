package app.strategies.countingSortingStrategy

import app.OneToOneRelation

class AscendingIterable<T>(
    private val coll: Collection<T>,
    private val objToIntRelation: OneToOneRelation<T, Int>
) : Iterable<T> {

    override fun iterator() =
        AscendingIterator(coll, objToIntRelation)
}