//adding express dependency
const express=require('express')
//instantiating the server using express
const app=express()
//creating a port for the server to serve at
//and listen to it
//localhost 4000:(port this is going to be served at)
//will be giving us error because there is really nothing to be
//served as we dont have endpoint/routes
app.listen(4000,()=>{
    console.log('Listening for requests on port 4000')
})

