const graphql = require('graphql')

//dummy data
var usersData=[
    {id:'11',name:'Alex',age:32},
    {id:'12',name:'Bella',age:19},
    {id:'13',name:'Mona',age:20},
    {id:'14',name:'Joan',age:39},
    {id:'15',name:'Triss',age:26}
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
    name: 'USER',
    description: 'Documentation for user...',
    fields: () => ({
        id: { type: GraphQLString },
        name: { type: GraphQLString },
        age: { type: GraphQLInt }
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
                let user = {
                    id: 'ID66',
                    name: 'Shantanu Roy',
                    age: 20
                }
                return user
            }
        }
    }
})
module.exports = new GraphQLSchema({
    query: RootQuery
})
