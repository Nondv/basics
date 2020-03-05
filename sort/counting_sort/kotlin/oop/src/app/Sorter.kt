package app


interface Sorter<T> {
    fun sort(coll: Collection<T>) : Collection<T>
}