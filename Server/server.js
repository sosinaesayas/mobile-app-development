// instantiate npm 
// install and configure nodemon

const {app} = require('./app')
const http = require("http")
const PORT = 5001
const mongoose = require("mongoose")

const MONGO_URL = "mongodb+srv://biniyamhaile:LTJs4XhV5amZckG@cluster0.38iwkgp.mongodb.net/?retryWrites=true&w=majority"
 


const server = http.createServer(app)

mongoose.set('strictQuery', true);
mongoose.connection.once("open" , ()=>{
    console.log("mongoDB connection ready!")
})

mongoose.connection.on("error" , (error)=>{
    console.error(error);
})

async function startServer(){
    await mongoose.connect(MONGO_URL)
    
    server.listen(PORT , ()=>{
        console.log(`Listening on port : ${PORT}`)
    })

 
}

startServer()
 