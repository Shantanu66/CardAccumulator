const graphql=require('graphql')

const {
    GraphQLObjectType,
    GraphQLSchema,
    GraphQLID,
    GraphQLString,
    GraphQLInt,
    GraphQLBoolean,
    GraphQLFloat,
    GraphQLNonNull
}=graphql

//Scalar type(not an object predefined DT/primitve DT)
const person=new GraphQLObjectType({
    name:"Person",
    description:'Created a Person type using the graphqlobject type',
    fields:()=>({
        id:{type:GraphQLID},
        name:{type:new GraphQLNonNull(GraphQLString)},
        age:{type:GraphQLInt},
        isMarried:{type:GraphQLBoolean},
        gpa:{type:GraphQLFloat}
    })
})

const RootQuery=new GraphQLObjectType({
    name:'RootQueryType',
    description:'Description',
    fields:{
        person:{
            type:person,
            description:'Non Nullable',


        }
    }
})

module.exports=new GraphQLSchema({
    query:RootQuery,
})