const mongoose=require('mongoose')
const mongoose_schema=mongoose.Schema

mongoose.set("useFindAndModify",false)

const idcardSchema=new mongoose_schema({
    title:String,
    description:String,
    cardnumber:Number
})
module.exports=mongoose.model("Idcard",idcardSchema)