package app.sorters

import app.SortingStrategy
import app.strategies.IntCountingSortingStrategy
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import kotlin.random.Random



internal class StrategyBasedSorterTest {
    @Test
    fun integrationTest() {
        testStrategy(DemoIntSortingStrategy)
        testStrategy(IntCountingSortingStrategy)
    }

    private fun testStrategy(strategy: SortingStrategy<Int>) {
        val sorter = StrategyBasedSorter(strategy)

        assertArrayEquals(intArrayOf(1, 2, 3, 4, 5), sorter.sort(intArrayOf(5, 4, 3, 2, 1).toList()).toIntArray())

        for (i in 1..10) {
            val arr = IntArray(1000) { Random.nextInt(2000) - 1000 }
            assertArrayEquals(arr.sortedArray(), sorter.sort(arr.toList()).toIntArray())
        }
    }

    internal object DemoIntSortingStrategy : SortingStrategy<Int> {
        override fun sort(coll: Collection<Int>) = coll.toIntArray().sorted()
    }
}

