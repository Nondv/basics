import app.SorterFactory

fun main(args : Array<String>) {
    val sorter = SorterFactory.intCountingSorter()
    sorter.sort(args.map { a -> a.toInt() }).forEach { x ->
        print(x)
        print(" ")
    }
    println()
}