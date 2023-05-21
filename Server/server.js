const app = require("./app")
const PORT = 5001
const http = require("http")
const mongoose = require("mongoose")

const MONGO_URL = "mongodb+srv://biniyhaile:28BUnn4Ovog4e3kx@cluster0.ldiomin.mongodb.net/"

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
