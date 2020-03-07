package app

interface OneToOneRelation<X, Y> {
    fun y(x: X) : Y
    fun x(y: Y) : X
}