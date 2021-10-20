const graphql = require('graphql')
var lodash = require('lodash')

//reference the db models
const holder=require("./Database/holder")
const idcard=require("./Database/idcard")
const bankcard=require("./Database/bankcard")
const { assign } = require('lodash')

/*dummy data
var holdersData = [
    { id: '1', name: 'Alex',mail:'Alex@mail.com' ,age: 32, profession: 'Software Developer' },
    { id: '2', name: 'Bella',mail:'Bella@mail.com' , age: 29, profession: 'Stock trader' },
    { id: '3', name: 'Mona',mail:'Mona@mail.com' , age: 20, profession: 'Buisness Analyst' },
    { id: '4', name: 'Joan',mail:'Joan@mail.com' , age: 39, profession: 'Writer' },
    { id: '5', name: 'Triss',mail:'Triss@mail.com' , age: 26, profession: 'Model' }
]
var IDCardData = [
    { id: '1', title: 'Aadhar Card', description: 'Government issued ID for verifiaction'
    , cardnumber: "670090002000",holderId:'1'},
    { id: '2', title: 'Pan Card', description: 'ID for income Tax' 
    , cardnumber: "E101776362D1",holderId:'2'},
    { id: '3', title: 'Driving License', description: 'License for driving vehicles'
    , cardnumber: "JH0123456789" ,holderId:'1'},
    { id: '4', title: 'Voter ID', description: 'ID for authorized voter'
    , cardnumber: "K06101",holderId:'4' },
    { id: '5', title: 'Passport', description: 'a formal document or certification issued by a national government identifying a traveler as a citizen or national with a right to protection while abroad and a right to return to the country of citizenship'
    , cardnumber: "1000E100K",holderId:'5' }
]
var BankCardData = [
    { id: '1',bank:"ICICI",validity:"06/27", number: "4045 2078 5000 2345" ,
    holderId:'1'},
    { id: '2',bank:"SBI",validity:"03/29", number: "5678 1234 2300 9000" ,
    holderId:'1'},
    { id: '3',bank:"HDFC",validity:"07/21", number: "8900 3456 2780 1000" ,
    holderId:'2'}
]*/

const {
    GraphQLObjectType,
    GraphQLID,
    GraphQLString,
    GraphQLInt,
    GraphQLSchema,
    GraphQLList,
    GraphQLNonNull
} = graphql

//create types
const holderType = new GraphQLObjectType({
    name: 'Holder',
    description: 'Documentation for Holder...',
    fields: () => ({
        id: { type: GraphQLID },
        //name:{type:new GraphQLNonNull(GraphQLString)},(for it to be non null)
        name: { type: GraphQLString },
        age: { type: GraphQLInt },
        mail:{type:GraphQLString},
        profession: { type: GraphQLString },
        idcards:{
            type:new GraphQLList(IDCardType),
            resolve(parent,args){
                  return idcard.find({holderId:parent.id})
                //return lodash.filter(IDCardData,{holderId:parent.id})
            }
        },
        bandcards:{
            type:new GraphQLList(BankCardType),
            resolve(parent,args){
                  return bankcard.find({holderId:parent.id})
                //return lodash.filter(BankCardData,{holderId:parent.id})
            }

        }
    })
})
const IDCardType = new GraphQLObjectType({
    name: 'GovernmentCard',
    description: 'Name of the Government Card',
    fields: () => ({
        id: { type: GraphQLID },
        title: { type: GraphQLString },
        description: { type: GraphQLString },
        cardnumber: { type: GraphQLID },
        DOB:{type:GraphQLID},
        holder:{
            type:holderType,
            resolve(parent,args){
                return lodash.find(holdersData,{id:parent.holderId})
            }
        }
    })
})
const BankCardType = new GraphQLObjectType({
    name: 'BankCards',
    description: 'Credit/Debit Cards',
    fields: () => ({
        id: { type: GraphQLID },
        bank:{type:GraphQLString},
        validity:{type:GraphQLID},
        number: { type: GraphQLID },
        //holderId:{type:GraphQLID},
        holder:{
            type:holderType,
            resolve(parent,args){
                return lodash.find(holdersData,{id:parent.holderId})
            }
        }
    })
})

//RootQuery creation
const RootQuery = new GraphQLObjectType({
    name: 'RootQueryType',
    description: 'Root Query desc',
    fields: {
        holder: {
            type: holderType,
            //what argument we need to pass with the main query
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                //where we resolve with data
                //get and return data from a datasource
                return holder.findById(args.id)
                //return lodash.find(holdersData, { id: args.id })
            }
        },
        holders:{
            type:new GraphQLList(holderType),
            resolve(parent,args){
                return holder
            }
        },
        idcard: {
            type: IDCardType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return lodash.find(IDCardData, { id: args.id })
            }
        },
        idcards:{
            type:new GraphQLList(IDCardType),
            resolve(parent,args){
                return IDCardData
            }
        },
        bankcard: {
            type: BankCardType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return lodash.find(BankCardData, { id: args.id })
            }
        },
        bankcards:{
            type:new GraphQLList(BankCardType),
            resolve(parent,args){
                return BankCardData
            }
        },
    }
})
//Mutations
const Mutation=new GraphQLObjectType({
   name:'Mutation',
   fields:{
       //Create User
       createHolder:{
           type:holderType,
           args:{
               name:{type:new GraphQLNonNull(GraphQLString)},
               age: { type: new GraphQLNonNull(GraphQLInt) },
               mail:{type:new GraphQLNonNull(GraphQLString)},
               profession: { type:new GraphQLNonNull(GraphQLString) },
           },
           resolve(parent,args){
               let Holder=holder({
                   name:args.name,
                   age:args.age,
                   mail:args.mail,
                   profession:args.profession
               })
               return Holder.save()
           }
    },
    //Update Holder
    UpdateHolder:{
        type:holderType,
        args:{
               id:{type:new GraphQLNonNull(GraphQLString)},           
               name:{type:new GraphQLNonNull(GraphQLString)},
               age: { type: new GraphQLNonNull(GraphQLInt) },
               mail:{type:new GraphQLNonNull(GraphQLString)},
               profession: { type:new GraphQLNonNull(GraphQLString) },
        },
        resolve(parent,args){
            return UpdateHolder=holder.findByIdAndUpdate(
                args.id,
                {
                    $set:{
                        name:args.name,
                        age:args.age,
                        mail:args.mail,
                        profession:args.profession
                    }
                },
                {new:true}//send back the updated holder type
            )
        }
    },
    createIDcard:{
        type:IDCardType,
        args:{
            title: { type: new GraphQLNonNull(GraphQLString )},
            description: { type: new GraphQLNonNull(GraphQLString) },
            cardnumber: { type: new GraphQLNonNull(GraphQLID) },
            DOB:{type:new GraphQLNonNull(GraphQLID)},
            holderId:{type:new GraphQLNonNull(GraphQLID)},
        },
        resolve(parent,args){
            let IDcard=idcard({
                title:args.title,
                description:args.description,
                cardnumber:args.cardnumber,
                DOB:args.DOB,
                holderId:args.holderId
            })
            return IDcard.save()
        }
    },
    UpdateIdcard:{
        type:IDCardType,
        args:{
            id:{type:new GraphQLNonNull(GraphQLString)},
            title: { type: new GraphQLNonNull(GraphQLString )},
            description: { type: new GraphQLNonNull(GraphQLString) },
            cardnumber: { type: new GraphQLNonNull(GraphQLID) },
            DOB:{type:new GraphQLNonNull(GraphQLID)},
            holderId:{type:new GraphQLNonNull(GraphQLID)},
        },
        resolve(parent,args){
            return UpdateIdcard=idcard.findByIdAndUpdate(
                args.id,
                {
                    $set:{
                        title:args.title,
                        description:args.description,
                        cardnumber:args.cardnumber,
                        DOB:args.DOB,
                        holderId:args.holderId
                    }
                },
                {new:true}//send back the updated holder type
            )
        }
    },
    createBankcard:{
        type:BankCardType,
        args:{
            bank:{type:new GraphQLNonNull(GraphQLString)},
            validity:{type:new GraphQLNonNull(GraphQLID)},
            number: { type:new GraphQLNonNull( GraphQLID) },
            holderId:{type:new GraphQLNonNull(GraphQLString)}
        },
        resolve(parent,args){
            let BankCard=bankcard({
                bank:args.bank,
                validity:args.validity,
                number:args.number,
                holderId:args.holderId
            })
            return BankCard.save()
        }
    }
   }
})
module.exports = new GraphQLSchema({
    query: RootQuery,
    mutation:Mutation,
})
