const mongoose=require('mongoose')
const mongoose_schema=mongoose.Schema
const ObjectID=mongoose_schema.ObjectID

const bankcardSchema= mongoose_schema({
    bank:String,
    validity:ObjectID,
    number:ObjectID,
})

module.exports=mongoose.model("Bankcard",bankcardSchema)
