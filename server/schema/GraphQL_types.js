const graphql=require('graphql')

const {
    GraphQLObjectType,
    GraphQLSchema,
    GraphQLID
}=graphql

//Scalar type(not an object predefined DT/primitve DT)
const person=new GraphQLObjectType({
    name:"Person",
    description:'Created a Person type using the graphqlobject type',
    fields:()=>({
        id:{type:GraphQLID}
    })
})

const RootQuery=new GraphQLObjectType({
    name:'RootQueryType',
    description:'Description',
    fields:{

    }
})

module.exports=new GraphQLSchema({
    query:RootQuery,
})