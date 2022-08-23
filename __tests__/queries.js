const app = require("../app");
const supertest = require("supertest");
const {startDatabase}=require("../database");
const mongoose=require('mongoose')

// const request = supertest('https://card-accumulator-dev.herokuapp.com');

const request = supertest(app);
beforeAll(async () => {
  mongoose.connect(`mongodb+srv://${process.env.mongoUserName}:${process.env.mongoUserPassword}@cardaccumulator.ctoe1.mongodb.net/${process.env.mongoDB}?retryWrites=true&w=majority`,
    { useNewUrlParser: true, useUnifiedTopology: true })
});

test("fetch all holders present in database",  (done) => {
  
  request
    .post("/graphql")
    .send({
      query: "{ holders{ id, name,age,mail,profession} }"
    })
    .set("Accept", "application/json")
    .expect("Content-Type", /json/)
    .expect(200)
    .end(done())
});
test("Create a test holder to check if it gets stored in the DB",  (done) => {
    
    request
      .post("/graphql")
      .send({
        mutation: "{ createHolder(name:Shantanu, age:22,mail:Shantanur66@gmail.com,profession:profession){name,age,mail,profession,id}}",
        
        })
      
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200)
      .end(done())
  });
  test("checking the Deletion of the test holder from the DB to reset it to default state",  (done) => {
    const db=mongoose.connection
    const {_id:userId}=db.collection("holders").findOne({name:"Shantanu"})
    
  // const {_id:userId}=mongoose.Collection("holders").findOne({name:"Shantanu"})
  request
    .post("/graphql")
    .send({
      mutation: "{ RemoveHolder(id:"+userId+"){name}",
      })
    .set("Accept", "application/json")
    .expect("Content-Type", /json/)
    .expect(200)
    .end(done())
});