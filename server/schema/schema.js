const graphql = require('graphql')
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
