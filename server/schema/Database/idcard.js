const mongoose=require('mongoose')
const mongoose_schema=mongoose.Schema

mongoose.set("useFindAndModify",false)

const idcardSchema=new mongoose_schema({
    name:String,
    age:Number,
    mail:String,
    profession:String
})
module.exports=mongoose.model("Idcard",idcardSchema)