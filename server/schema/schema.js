const graphql=require('graphql')
const {
    GraphQLObjectType,
    GraphQLID,
    GraphQLString,
    GraphQLInt
}=graphql()

//create types
const UserType=new GraphQLObjectType({
    name:'USER',
    description:'Documentation for user...',
    fields:()=>({
        id:{type:GraphQLID},
        name:{type:GraphQLString},
        age:{type:GraphQLInt}
    })
})

