package app

interface SortingStrategy<T> {
    fun sort(coll: Collection<T>) : Collection<T>
}