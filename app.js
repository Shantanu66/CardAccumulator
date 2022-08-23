//adding express dependency
const express=require('express')
//object i can use to interact with nodejs,express,js,etc
const { graphqlHTTP }=require('express-graphql')
const schema=require('./server/schema/schema')
const mongoose=require('mongoose')
const cors=require('cors')
const port=process.env.PORT || 5000
//instantiating the server using express
const app=express()
//mongodb+srv://Shantanu:<password>@cardaccumulator.ctoe1.mongodb.net/myFirstDatabase?retryWrites=true&w=majority
//app.use/the server will use the graph API to communicate
//using cors(cross origin resource origin)
const context = async () => {
    const db = await startDatabase();
  
    return { db };
  };
app.use(cors())
app.use("/graphql",graphqlHTTP({
    graphiql:true,
    schema:schema
    
}))
//connecting our server with mongoDB
mongoose.connect(`mongodb+srv://${ process.env.mongoUserName}:${process.env.mongoUserPassword}@cardaccumulator.ctoe1.mongodb.net/${process.env.mongoDB}?retryWrites=true&w=majority`,
{useNewUrlParser:true,useUnifiedTopology:true}).then(()=>{
    app.listen({port:port},()=>{
        console.log('Listening for requests on port '+port)
    })
}).catch((e)=>console.log("Error:::"+e))
//creating a port for the server to serve at
//and listen to it
//localhost 4000:(port this is going to be served at)
//will be giving us error because there is really nothing to be
//served as we dont have endpoint/routes

module.exports=app
