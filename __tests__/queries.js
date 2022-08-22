const app = require("../app");
const supertest = require("supertest");
const {stopDatabase}=require("../database");
const mongoose=require('mongoose')

// const request = supertest('https://card-accumulator-dev.herokuapp.com');
const request = supertest(app);
afterAll(async () => {
  await stopDatabase()
});
var id;
test("fetch all holders present in database", async () => {
  
  request
    .post("/graphql")
    .send({
      query: "{ holders{ id, name,age,mail,profession} }"
    })
    .set("Accept", "application/json")
    .expect("Content-Type", /json/)
    .expect(200)
    .end
});
test("Create a test holder to check if it gets stored in the DB", async () => {
    
    request
      .post("/graphql")
      .send({
        mutation: "{ createHolder(name:Shantanu, age:22,mail:Shantanur66@gmail.com,profession:profession){name,age,mail,profession,id}}",
        
        })
      
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200)
      .end
  });
  test("checking the Deletion of the test holder from the DB to reset it to default state", async () => {
    const {_id:userId}=mongoose.Collection("holders").findOne({name:"Shantanu"})
    request
      .post("/graphql")
      .send({
        mutation: `{ RemoveHolder(id:${userId}){name,age,mail,profession}}{name}`,
        })
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200)
      .end
  });