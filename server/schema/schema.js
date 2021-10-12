const graphql = require('graphql')
var lodash=require('lodash')

//dummy data
var usersData=[
    {id:'11',name:'Alex',age:32,profession:'Software Developer'},
    {id:'12',name:'Bella',age:19,profession:'Stock trader'},
    {id:'13',name:'Mona',age:20,profession:'Buisness Analyst'},
    {id:'14',name:'Joan',age:39,profession:'Writer'},
    {id:'15',name:'Triss',age:26,profession:'Model'}
]

const {
    GraphQLObjectType,
    GraphQLID,
    GraphQLString,
    GraphQLInt,
    GraphQLSchema
} = graphql

//create types
const UserType = new GraphQLObjectType({
    name: 'User',
    description: 'Documentation for user...',
    fields: () => ({
        id: { type: GraphQLID },
        name: { type: GraphQLString },
        age: { type: GraphQLInt },
        profession:{type:GraphQLString}
    })
})
const CardType=new GraphQLObjectType({
    name:'Card Name',
    description:'Name of the Government Card',
    fields:()=>({
        id:{type:GraphQLID},
        title:{type:GraphQLString},
        description:{type:GraphQLString}
    })
})

//RootQuery creation
const RootQuery = new GraphQLObjectType({
    name: 'RootQueryType',
    description: 'Root Query desc',
    fields: {
        user: {
            type: UserType,
            //what argument we need to pass with the main query
            args: { id: { type: GraphQLString } },
            resolve(parent, args) {
                //where we resolve with data
                //get and return data from a datasource
                return lodash.find(usersData,{id:args.id})
            }
        }
    }
})
module.exports = new GraphQLSchema({
    query: RootQuery
})
