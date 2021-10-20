const mongoose=require('mongoose')
const mongoose_schema=mongoose.Schema


const idcardSchema= mongoose_schema({
    title:String,
    description:String,
    cardnumber:Number,
    DOB:Number
})
module.exports=mongoose.model("Idcard",idcardSchema)