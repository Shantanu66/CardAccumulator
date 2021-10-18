const mongoose=require('mongoose')
const mongoose_schema=mongoose.Schema
const ObjectID=mongoose_schema.ObjectID

mongoose.set("useFindAndModify",false)

const idcardSchema=new mongoose_schema({
    title:String,
    description:String,
    cardnumber:ObjectID,
    DOB:ObjectID
})
module.exports=mongoose.model("Idcard",idcardSchema)