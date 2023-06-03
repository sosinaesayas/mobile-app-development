const freelancer = require("./freelancer.mongoose")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const uuid = require("uuid")
const multer = require("multer")
const  { getJobById}  = require("../job/job.model")
const jobMongoose = require("../job/job.mongoose")
const job = require("../job/job.mongoose")
require("dotenv").config()



 const config = {
    COOKIE_KEY : process.env.COOKIE_KEY
}



async function createFreelancer(body){
   
  const existObj =   await freelancer.find({email : body.email})


    hashedPassword = await bcrypt.hash(body["password"] , 10)

    body["password"] =hashedPassword;
    
    body["id"] = uuid.v4()

    try {
        if (!existObj.length){
            await freelancer.findOneAndUpdate({email : body.email} , body , {upsert : true})
            return true
        
          } else if(existObj.length){
            return "this email already exist!"
          }
          else{
            return "Invalid credentials!"
          }
    } catch (error) {
       
        return false
    }

   
    
}












async function loginFreelancer(req , res){

  const user = await  freelancer.findOne({
    email : req.body.email 
}).select("+password")



if(!user){
   
    return false

}   
else if(await bcrypt.compare(req.body.password , user.password )){

    const token = jwt.sign( 
        {email : user.email , name : user.firstName  , department : user.department , id : user.id} , config.COOKIE_KEY
    )
    return res.status(200).json({ entity : "freelancer" ,   token : token , id : user.id ,phone : user.phone , department : user.department , description : user.description  ,  firstName : user.firstName , lastName : user.lastName , email : user.email})


}    
else{
  
    return false;
}


}


async function isOldPasswordValid(id , password){
    const user = await  freelancer.findOne({
        id : id 
    }).select("+password")
    

    if(await bcrypt.compare(password , user.password )){
        console.log("here?")
         return true
     
     }    
     else{
        console.log("false")
         return false;
     }
    
   
}




async function updatePassword(id , newPassword){
    hashedPassword = await bcrypt.hash(newPassword , 10)

    try {
        await  freelancer.findOneAndUpdate({id : id } , {password : hashedPassword})
    } catch (error) {
        return false;
    }
    return true;
}










async function sendAuthentication(id){
    const user = await  freelancer.findOne({
        id : id 
    }).select("+password")

    
    const token = jwt.sign( 
        {email : user.email , name : user.firstName  , department : user.department , id : user.id} , config.COOKIE_KEY
    )
   
    return  { entity : "freelancer" ,   token : token , id : user.id ,phone : user.phone , department : user.department , description : user.description  ,  firstName : user.firstName , lastName : user.lastName , email : user.email}




}
 
async function addAppliedJob(freelancerId , jobId){
        try {
         result=   await freelancer.updateOne(
            {id  : freelancerId}  , {$push : {appliedJobs : jobId}})

            const me = await freelancer.find({id : freelancerId})
            console.log(`********************** ${result}`)
            console.log(me)
           return me
        } catch (error) {
           console.log("mistake")
           console.log(error)
            return false
        }
}






async function getAppliedPeople(job_id){
    try{
        const result =  await freelancer.find({appliedJobs : job_id} , {job_id : 0  , password : 0 })
        return result
    }
    catch(error){
      
        return false
    }
}



async function getRandomFreelancers(){
    return freelancer.aggregate([
        { $sample: { size: 8 } },
        {
          $project: {
            appliedJobs: 0,
            connections: 0,
            notifications: 0,
            _id: 0,
            password: 0, 
            __v : 0
          }
        }
      ]);
    
      
      
      
      
      
      
}


async function createNotification(id , body){
    try {
        await freelancer.updateOne({id : id} , {$push : {notifications : body}})
        return true
    } catch (error) {
        console.log(error)
        return false
    }
}


async function getNotificationCount(email){
    
    try {
      
        const user = await freelancer.find({email: email})
        const checkNotifications = (notification) => notification.unread === true;
        if(user[0].notifications){
            const listOfNotifications = user[0].notifications.filter(checkNotifications)
      
       
            return listOfNotifications.length
        }else{
            return 0
        }


    
          
    } catch (error) {
        console.log(error)
        return false
    }
}

async function getFreelancerByEmail(email){
    try{
        const result =  await freelancer.find({
            email : email 
        }, {
            password  : 0 , 
            appliedJobs : 0 , 
            notifications : 0 , 
            connections : 0 , 
            _id : 0 , 
            __v : 0
        })

       


        return result[0]
    }catch(error){
        return false
}
}

async function getAllNotifications(email){

   
try{
   const  result= await freelancer.find({
        email : email 
    } )
    
    await freelancer.updateMany(
        {email : email , "notifications.unread" : true}  , 
        {$set : {"notifications.$.unread" : false}}
    )
   
   
    return  result[0].notifications.reverse()
}catch(error){
    console.log(error)
    return false
} 
}

async function getAppliedFreelancer(freelancerId){
    try{
       return await freelancer.findOne({
            id : freelancerId
        } , {
            _id: 0 , 
            connections : 0 , 
            notifications : 0 , 
            appliedJobs : 0 , 
            __v : 0 ,
        })

    }catch(err){
        console.log(err)
        return false
    }
}


async function checkApplied(freelancerId , jobId){
    try{
        const result = await freelancer.findOne(
            {
                id : freelancerId , 
                appliedJobs : jobId
            } , {
                appliedJobs : 1
            }
        )   

   

        return result
    } catch(error){
        console.log(error)
        return false
    }
}

async function searchFreelancer(name){
    
    const pipeline =  [
        {
          $search: {
            index: "name",
            text: {
              query: name,
              path: ["firstName" , "lastName" , "description"],
              
            }
          } , 
        
        } , 
        {
            $project : {
                _id : 0 ,
                appliedJobs : 0 , 
                notifications  : 0 , 
                password  : 0
              } ,
              
        }
      ]



      try{
        const result = await freelancer.aggregate(pipeline)
        return result
      }catch(error){
        console.log(error)
        return false
      }
}

async function pushConnection(id  , email){
    
    try {
        const result  = await freelancer.updateOne(
            { id: id},
            { $push: { connections: email } }
         )
       
       
        return result

    } catch (error) {
       
        return false
    }
}


async function checkConnection(personId ,companyEmail){
    try {
        const result = await freelancer.findOne(
            {
                id : personId ,
                connections : companyEmail
            }
        )
            
            
       
        if(result === null){
           
            return false
        }
       
        return true
    } catch (error) {
        console.log(error)
        return false
    }
}

async function getAppliedJobs(email){
        try{
            const result =  await freelancer.find({
                email : email
            } , {
                appliedJobs : 1,
                _id : 0
            })
            console.log(result)
          

            myjobs = []
            for(let i = 0 ; i < result[0]['appliedJobs'].length ; i++){    
                myjob = {}
               
                id =   result[0]['appliedJobs'][i]
               
                fjob =  await  job.find({id : id})
               
                myjob['description'] = fjob['description'],  
                myjob['title'] =fjob['title']
                myjob['deadline'] = fjob['deadline'],
                myjob['status'] = fjob['status'] , 
                myjob['department'] = fjob['department'],
                myjob['id'] = fjob['id'],
                num =  fjob['personsApplied'][0]
                myjob['appliedpeople'] =num.length
                myjob['companyName'] = fjob['companyName'] , 
                myjob['dateCreated'] = fjob['dateCreated']
                myjobs.push(myjob)
                
           
             }
            
             
         
       
              return myjobs;
        }catch(error){
            console.log(error)
            return false
        }
}

async function getProfile(freelancerId){
    try {
        result =  await freelancer.findOne({
            id : freelancerId
        } , {
              
            _id : 0 , 
            firstName : 1  , 
            lastName : 1 , 
            email : 1 , 
            description : 1 , 
            phone : 1,
            department : 1

        })


       

        



        return result

    } catch (error) {
        console.log(error)
        return false
    }
}


async function checkEmail(email){
    try{
        result = await freelancer.find({
            email : email
        })
       
        return result.length
    }catch{
        return false
    }
}

async function updateProfile(freelancerId , body){
    try {
        result = await freelancer.updateOne(
            {
                id : freelancerId
            } , 
            body
        )
        console.log(result)
            console.log("updated!")

        return true
    } catch (error) {
        return false
    }


    
}

async function deleteFreelancerById(id){
    console.log(id)
        try {
            result = await freelancer.deleteOne({
               id : id
            })
           console.log(result)
            return true
        } catch (error) {
            console.log(error)
           return false

        }
}

module.exports = {
    updateProfile,
    checkEmail ,
    getAppliedFreelancer , 
    getFreelancerByEmail ,
    getAppliedJobs , 
    checkConnection , 
    pushConnection , 
    searchFreelancer , 
    checkApplied , 
    getAllNotifications ,
    getNotificationCount, 
    createNotification, 
    getRandomFreelancers,
    addAppliedJob , 
    createFreelancer , 
    loginFreelancer, 
    getAppliedPeople ,
    getProfile, 
    config , 
    sendAuthentication,
    isOldPasswordValid,
    updatePassword, 
    deleteFreelancerById
   
}