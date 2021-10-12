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
var IDCardData = [
    { id: '1', title: 'Aadhar Card', description: 'Government issued ID for verifiaction'
    , cardnumber: "670090002000"},
    { id: '2', title: 'Pan Card', description: 'ID for income Tax' 
    , cardnumber: "E101776362D1"},
    { id: '3', title: 'Driving License', description: 'License for driving vehicles'
    , cardnumber: "JH0123456789" },
    { id: '4', title: 'Voter ID', description: 'ID for authorized voter'
    , cardnumber: "K06101" },
    { id: '5', title: 'Passport', description: 'a formal document or certification issued by a national government identifying a traveler as a citizen or national with a right to protection while abroad and a right to return to the country of citizenship'
    , cardnumber: "1000E100K" }
]
var BankCardData = [
    { id: '1',name:"ICICI",validity:"06/27", number: "4045 2078 5000 2345" },
    { id: '2',name:"SBI",validity:"03/29", number: "5678 1234 2300 9000" },
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
const IDCardType = new GraphQLObjectType({
    name: 'GovernmentCard',
    description: 'Name of the Government Card',
    fields: () => ({
        id: { type: GraphQLID },
        title: { type: GraphQLString },
        description: { type: GraphQLString },
        cardnumber: { type: GraphQLID }
    })
})
const BankCardType = new GraphQLObjectType({
    name: 'BankCards',
    description: 'Credit/Debit Cards',
    fields: () => ({
        id: { type: GraphQLID },
        name:{type:GraphQLString},
        validity:{type:GraphQLID},
        number: { type: GraphQLID }
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
        idcard: {
            type: IDCardType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return lodash.find(IDCardData, { id: args.id })
            }
        },
        bankcard: {
            type: BankCardType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return lodash.find(BankCardData, { id: args.id })
            }
        }
    }
})
module.exports = new GraphQLSchema({
    query: RootQuery
})
