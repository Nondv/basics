package app

class Counter<T>(private val array : Iterable<T>) {
    private val counters = HashMap<T, Int>()
    init {
        array.forEach { x ->
            val current = counters[x] ?: 0
            counters[x] = current + 1
        }
    }

    fun count(x : T) = counters[x] ?: 0
}