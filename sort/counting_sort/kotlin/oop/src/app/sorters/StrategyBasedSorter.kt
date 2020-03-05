package app.sorters

import app.Sorter
import app.SortingStrategy

class StrategyBasedSorter<T>(private val strategy: SortingStrategy<T>) :
    Sorter<T> {
    override fun sort(coll: Collection<T>) = strategy.sort(coll)
}