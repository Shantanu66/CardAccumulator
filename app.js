//adding express dependency
const express=require('express')
//object i can use to interact with nodejs,express,js,etc
const { graphqlHTTP }=require('express-graphql')
const schema=require('./server/schema/schema')
const { startDatabase } = require("./database");
const cors=require('cors')

//instantiating the server using express
const app=express()
const context = async () => {
    const db = await startDatabase();
  
    return { db };
  };
//mongodb+srv://Shantanu:<password>@cardaccumulator.ctoe1.mongodb.net/myFirstDatabase?retryWrites=true&w=majority
//app.use/the server will use the graph API to communicate
//using cors(cross origin resource origin)
app.use(cors())
app.use("/graphql",graphqlHTTP({
    graphiql:true,
    schema:schema,
    context:context
}))
//connecting our server with mongoDB

module.exports=app
//creating a port for the server to serve at
//and listen to it
//localhost 4000:(port this is going to be served at)
//will be giving us error because there is really nothing to be
//served as we dont have endpoint/routes


