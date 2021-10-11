const graphql=require('graphql')
const {GraphQLObjectType}=graphql()

//create types
const UserType=new GraphQLObjectType({
    name:'USER',
    description:'Documentation for user...',
    fields:()=>({
        id:'1234',
        name:'Shantanu',
        age:20
    })
})

