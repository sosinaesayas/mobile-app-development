const mongoose = require("mongoose")
const freelancerSchema = new mongoose.Schema(
    {
          
            firstName : {
                type : String ,
                required : true
            },
            lastName : {
                type : String ,
                required : true
            } , 
            experience : {
                type : Number , 
                required : true
            } , 
            location : {
                type : String,
                required : true
            } , 
            department :{
                type : String,
                required : true
            } , 
            phone : {
                type : String ,
                required : true
            } , 
            password :{
                type : String,
                required : true , 
                select : false , 
            },

           

            appliedJobs : [] , 
            description : {
                type : String,
                required : true
            } , 
            email : {
                type : String,
                required : true , 
            } , 
            id : {
                type: String ,
                required : true ,
            } , 
            notifications : [],
            connections : []
            
        }
)



freelancerSchema.methods.matchPassword = async function (password) {
     try {
       return await bcrypt.compare(password, this.password);
     } catch (error) {
       throw new Error(error);
     }
    };
module.exports = mongoose.model("Freelancer" , freelancerSchema)
