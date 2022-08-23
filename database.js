const mongoose=require('mongoose')
const port=process.env.PORT || 5000
const app=require('./app')


async function startDatabase()
{
    mongoose.connect(`mongodb+srv://${ process.env.mongoUserName}:${process.env.mongoUserPassword}@cardaccumulator.ctoe1.mongodb.net/${process.env.mongoDB}?retryWrites=true&w=majority`,
    {useNewUrlParser:true,useUnifiedTopology:true}).then(()=>{
        app.listen({port:port},()=>{
            console.log('Listening for requests on port '+port)
         })
    }).catch((e)=>console.log("Error:::"+e))}
    async function stopDatabase(){
    mongoose.connection.close()
}
module.exports = {
   startDatabase,
    stopDatabase
  };