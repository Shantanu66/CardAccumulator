
const supertest = require("supertest");

const request = supertest('https://card-accumulator-dev.herokuapp.com');

var u

test("fetch all holders present in database",  () => {
  
  request
    .post("/graphql")
    .send({
      query: "{ holders{ id, name,age,mail,profession} }"
    })
    .set("Accept", "application/json")
    .expect("Content-Type", /json/)
    .expect(200)
    
});
test("Create a test holder to check if it gets stored in the DB",  () => {
    
    request
      .post("/graphql")
      .send({
        mutation: "{ createHolder(name:Shantanu, age:22,mail:Shantanur66@gmail.com,profession:profession){name,age,mail,profession,id}}",
        
        })
      
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200)
      
  });a
  test("Getting the holder id from mongodb collections for use in removal of test holder from database",  () => {
    
    
    // const {_id:userId}=mongoose.Collection("holders").findOne({name:"Shantanu"})
     const user_id=request
      .get("/graphql")
      .send({
        query:'{holdersID{id}}',
        })
      .set("Accept", "application/json")
      .expect("Content-Type", /json/)
      .expect(200)
      for (const [key, value] of Object.entries(user_id)) {
        u=value
      }
     
  });
 
  test("checking the Deletion of the test holder from the DB to reset it to default state",  () => {
    
  
  // const {_id:userId}=mongoose.Collection("holders").findOne({name:"Shantanu"})
  request
    .post("/graphql")
    .send({
      mutation: "{ RemoveHolder(id:"+u+"){name}",
      })
    .set("Accept", "application/json")
    .expect("Content-Type", /json/)
    .expect(200)
   
});