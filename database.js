const mongoose=require('mongoose')
const app=require('./app.js')
const port=process.env.PORT || 5000


async function startDatabase() {
    mongoose.connect(`mongodb+srv://${ process.env.mongoUserName}:${process.env.mongoUserPassword}@cardaccumulator.ctoe1.mongodb.net/${process.env.mongoDB}?retryWrites=true&w=majority`,
{useNewUrlParser:true,useUnifiedTopology:true}).then(()=>{
    app.listen({port:port},()=>{
        console.log(`Server ready at http://localhost:${port}/graphql`);
    })
}).catch((e)=>console.log("Error:::"+e))
}
async function stopDatabase(){
    mongoose.connection.close()
}
module.exports = {
    startDatabase,
    stopDatabase
  };