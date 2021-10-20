const mongoose=require('mongoose')
const mongoose_schema=mongoose.Schema

const bankcardSchema= mongoose_schema({
    bank:String,
    validity:String,
    number:Number,
    holderId:String
})

module.exports=mongoose.model("Bankcard",bankcardSchema)
