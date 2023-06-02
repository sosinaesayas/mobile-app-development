const mongoose = require("mongoose")
const companySchema = new mongoose.Schema({
    name  : {type : String  , required : true} , 
    email : {type : String , required : true} , 
    id : {type : String , required : true},
    password : {type : String , required : true},
    jobsPosted : [] , 
    location : {type : String}    

})

   
module.exports = mongoose.model("Company" , companySchema); 
