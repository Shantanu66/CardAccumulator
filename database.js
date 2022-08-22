const mongoose=require('mongoose')




async function startDatabase() {
    mongoose.connect(`mongodb+srv://${ process.env.mongoUserName}:${process.env.mongoUserPassword}@cardaccumulator.ctoe1.mongodb.net/${process.env.mongoDB}?retryWrites=true&w=majority`,
{useNewUrlParser:true,useUnifiedTopology:true})

}
async function stopDatabase(){
    mongoose.connection.close()
}
module.exports = {
    startDatabase,
    stopDatabase
  };