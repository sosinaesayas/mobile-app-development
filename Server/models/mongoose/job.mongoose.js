const mongoose = require("mongoose")


const jobSchema = new mongoose.Schema({
    title : {
        type : String ,
        required : true
    } , 
    department :{
        type : String ,
        required : true
    }  , 
    description : {
        type : String ,
        required : true
    }  , 
    location : {
        type : String ,
        required : true
    }  , 
    companyName : {
        type : String ,
        required : true , 
    }  , 
    personsApplied : {
        type : Array  , 
         required : false
    } , 
    deadline  : {
        type : Date , 
        required : true
    } , 
    salary  :{
        type : String , 
        required : false

    } , 
    dateCreated : {
        type : Date , 
        required : true
    } , 
    status : {
        type : String, 
        default : "Open", 
        required : false
    } , 
    id : {
     type : String , 
     required : true
    }
      

})


module.exports = mongoose.model("Job"  , jobSchema)