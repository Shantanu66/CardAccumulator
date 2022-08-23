const app = require("../app");
const supertest = require("supertest");
const {startDatabase}=require("../database");
const mongoose=require('mongoose')

// const request = supertest('https://card-accumulator-dev.herokuapp.com');

const request = supertest(app);
beforeAll(async () => {
  await startDatabase()
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
  