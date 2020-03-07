package app.oneToOneRelations

import app.OneToOneRelation

object IntIdentityRelation : OneToOneRelation<Int, Int> {
    override fun y(x: Int) = x
    override fun x(y: Int) = y
}