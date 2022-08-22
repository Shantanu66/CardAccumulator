const app = require("../app");
const supertest = require("supertest");
const {stopDatabase}=require("../database");
const mongoose=require('mongoose')

// const request = supertest('https://card-accumulator-dev.herokuapp.com');
const request = supertest(app);
afterAll(async () => {
  await stopDatabase()
});

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
  