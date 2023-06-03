const admin = require("./admin.mongoose")
const jwt = require("jsonwebtoken")
const bcrypt = require("bcrypt")
const uuid = require("uuid")
require("dotenv").config()

const config = {
    COOKIE_KEY : process.env.COOKIE_KEY
}
async function loginAdmin(req , res){
    console.log("incoming request")
    const user = await  admin.findOne({
        email : req.body.email 
    })
         
    if(!user){
        return res.status(403).json({user : false , message : "email doesn't exist"}) //no user , so check the email!
    }   
    else if(await bcrypt.compare(req.body.password , user.password )){
    console.log("here")
        const token = jwt.sign(
            {email : user.email } , config.COOKIE_KEY
        )
        console.log("authenticated admin")
        return res.status(200).json({   token : token ,  entity : "admin"})
    } 
    else{
        return res.status(403).json({user : false , message : "passwords didn't match"})
    }
}


async function CreateAdmin(){
    hashedPassword = await bcrypt.hash("admin" , 10)

   
   
    


   try {
    result=   await admin.findOneAndUpdate({email : "admin@gmail.com"} , {email : "admin@gmail.com" , password : hashedPassword} , {upsert : true})
    console.log(result)
    
   } catch (error) {
    console.log(error)
   }
   
        
       
  
}



module.exports = {loginAdmin , CreateAdmin}