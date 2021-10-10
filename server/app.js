//adding express dependency
const express=require('express')
//instantiating the server using express
const app=express()
//creating a port for the server to serve at
//and listen to it
app.listen(4000,()=>{
    console.log('Listening for requests on port 4000');
})

