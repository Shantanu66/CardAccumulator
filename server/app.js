//adding express dependency
const express=require('express')
//object i can use to interact with nodejs,express,js,etc
const { graphqlHTTP }=require('express-graphql')
const schema=require('./schema/schema')
const mongoose=require('mongoose')
//instantiating the server using express
const app=express()
//mongodb+srv://Shantanu:<password>@cardaccumulator.ctoe1.mongodb.net/myFirstDatabase?retryWrites=true&w=majority
//app.use/the server will use the graph API to communicate
app.use('/graphQL',graphqlHTTP({
    graphiql:true,
    schema:schema
}))
//connecting our server with mongoDB
mongoose.connect(`mongodb+srv://Shantanu:<password>@cardaccumulator.ctoe1.mongodb.net/myFirstDatabase?retryWrites=true&w=majority`)
//creating a port for the server to serve at
//and listen to it
//localhost 4000:(port this is going to be served at)
//will be giving us error because there is really nothing to be
//served as we dont have endpoint/routes
app.listen(5000,()=>{
    console.log('Listening for requests on port 5000')
})

