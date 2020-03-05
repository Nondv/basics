package app

import app.sorters.StrategyBasedSorter
import app.strategies.IntCountingSortingStrategy

object SorterFactory {
    fun intCountingSorter() = StrategyBasedSorter(IntCountingSortingStrategy)
}