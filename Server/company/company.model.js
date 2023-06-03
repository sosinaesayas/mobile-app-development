const jwt = require("jsonwebtoken")
const bcrypt = require("bcrypt")
const company = require("./company.mongoose")
const uuid = require("uuid")
const { getJobById } = require("../job/job.model")

require("dotenv").config()

const config = {
    COOKIE_KEY : process.env.COOKIE_KEY
}




async function createCompany(body){
    
    const existObj =   await company.find({email : body.email})


    hashedPassword = await bcrypt.hash(body["password"] , 10)

    body["password"] =hashedPassword; 
    body['id'] = uuid.v4()

    try {
        if (!existObj.length){
            await company.findOneAndUpdate({email : body.email} , body , {upsert : true})
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


async function loginCompany(req , res){
    const user = await  company.findOne({
        email : req.body.email 
    })
         
    if(!user){
        // return res.status(403).json({user : false , message : "email doesn't exist"}) //no user , so check the email!
    return false
    }   
    else if(await bcrypt.compare(req.body.password , user.password )){
        const token = jwt.sign(
            {email : user.email , name : user.name , id : user.id} , config.COOKIE_KEY
        )
        console.log("authenticated company")
        return res.status(200).json({   token : token , name : user.name , email  : user.email , id : user.id , entity : "company"})
    } 
    else{
        return res.status(403).json({user : false , message : "passwords didn't match"})
    }
}



async function postJob(companyEmail , jobId){
    try{
         await company.updateOne({
            email : companyEmail
        } , {
            $push : {
                jobsPosted : jobId
            }
        })
        return true
    }catch(e){
        console.log(e)
        return false
    }
}


async function getPostedJobs(id) {

    const result = await company.findOne(
        { id: id },
        { _id: 0  }
    );

    const jobsPosted = result['jobsPosted']; 
 

    const jobsWithAppliedPeopleCount =  []
 
    for(let i = 0 ; i < jobsPosted.length ; i++){      
       job =  await getJobById(jobsPosted[i]) 
       
       if(!job){
            continue
        }
        
       job['description'] = job['description'],  
       job['title'] =job['title']
       job['deadline'] = job['deadline'],
       job['status'] = job['status'] , 
       job['department'] = job['department'],
       job['id'] = job['id'],
       job['appliedpeople'] = job['personsApplied'].length
       job['companyName'] = job['companyName'] , 
       job['dateCreated'] = job['dateCreated']
       jobsWithAppliedPeopleCount.push(job)
  
    }
    console.log(jobsWithAppliedPeopleCount.reverse())
    return jobsWithAppliedPeopleCount.reverse();

}
module.exports = {
    createCompany , loginCompany , postJob  , getPostedJobs
}