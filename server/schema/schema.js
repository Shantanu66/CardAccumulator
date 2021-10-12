const graphql = require('graphql')
var lodash = require('lodash')

//dummy data
var usersData = [
    { id: '11', name: 'Alex', age: 32, profession: 'Software Developer' },
    { id: '12', name: 'Bella', age: 19, profession: 'Stock trader' },
    { id: '13', name: 'Mona', age: 20, profession: 'Buisness Analyst' },
    { id: '14', name: 'Joan', age: 39, profession: 'Writer' },
    { id: '15', name: 'Triss', age: 26, profession: 'Model' }
]
var CardData = [
    { id: '1', title: 'Aadhar Card', age: 32, description: 'Government issued ID for verifiaction' },
    { id: '2', title: 'Pan Card', age: 19, description: 'ID for income Tax' },
    { id: '3', title: 'Driving License', age: 20, description: 'License for driving vehicles' },
    { id: '4', title: 'Voter ID', age: 39, description: 'ID for authorized voter' },
    { id: '5', title: 'Passport', age: 26, description: 'a formal document or certification issued by a national government identifying a traveler as a citizen or national with a right to protection while abroad and a right to return to the country of citizenship' }
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
        profession: { type: GraphQLString }
    })
})
const CardType = new GraphQLObjectType({
    name: 'Card',
    description: 'Name of the Government Card',
    fields: () => ({
        id: { type: GraphQLID },
        title: { type: GraphQLString },
        description: { type: GraphQLString }
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
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                //where we resolve with data
                //get and return data from a datasource
                return lodash.find(usersData, { id: args.id })
            }
        },
        card: {
            type: CardType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return lodash.find(CardData, { id: args.id })
            }
        }
    }
})
module.exports = new GraphQLSchema({
    query: RootQuery
})
