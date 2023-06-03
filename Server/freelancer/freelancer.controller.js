const { response } = require("express");
const { acceptFreelancer } = require("../job/job.model");
const {
    deleteFreelancerById,
    getAppliedFreelancer,
    getNotificationCount ,
    getAllNotifications ,
    getRandomFreelancers , 
     createFreelancer , 
     createNotification ,
     loginFreelancer , 
     getAppliedPeople , 
        checkApplied,  
        searchFreelancer,
        checkConnection, 
        pushConnection,
        getAppliedJobs,
        getProfile,
        checkEmail,
        updateProfile , 
        config,
        sendAuthentication,
        isOldPasswordValid,
        updatePassword,
        getPendingFreelancers,
        confirmFreelancer
    } = require("./freelancer.model");
const jwt = require('jsonwebtoken'); 
const { loginCompany } = require("../company/company.model");
const {loginAdmin} = require("../admin/admin.model")
async function httpCreateFreelancer(req , res){
    const body  = req.body
    console.log("reqiefudfuif")
   
    const returned  = await  createFreelancer(body);

    if(returned === true){
       
        res.status(200).json({
           
        })
    } else{
        
        res.status(400).json({
            message : returned
        })
    }

}




async function httpDeleteFreelancer(req  ,res){
    const id = res.locals.id
    console.log(id)
   result  = await deleteFreelancerById(id)
    // check if the freelancer exist in the database
   if(result){
    res.status(204).json({
        ok : true
    })
   }else{
    res.status(401).json({
        ok : false
    })
   }
}

function httpGetAllFreelancers(){

}

async function httpLoginFreelancer( req , res){

        result =  await loginFreelancer(req, res)

        if(result ){
            console.log("retured")
            console.log(result)
            return result
        }else{
            
            result =  await loginCompany(req ,res)
            if(result){
                return result
            }
        }
        console.log("here")
        res = await loginAdmin(req , res)
        return res
     }
     
     
async function httpGetAppliedPeople(req, res){
    const id = req.params.id
    const result = await getAppliedPeople(id)
    
    if(result){ 
        return res.status(200).json(result)
    }
    else{
        return res.status(400).json({ok : false})
    }
}     
     





async function httpGetRandomFreelancers(req, res){
  console.log("=============================")
    result = await getRandomFreelancers()
    console.log(result)
    if(result){
      return  res.status(200).json(result)
    }
    else{
       return res.status(400).json({ok : false})
    }
}


async function httpCreateNotification(req , res){
    console.log("------------request ----------------")
   
    const notification = req.body;

    const id = req.params.id
    notification.unread = true
    const email = res.locals.companyEmail
    
    if(notification['kind'] === 'connect'){
        check = await checkConnection(id , email);
        
         
        if(check){console.log(`ok is false`)
            return  res.status(200).json({ok : false})
        }else{
            
            const result = await pushConnection(id , email)
            
            if(!result){
                return res.status(200).json({ok : false})
            
        }

    }

    
    
    const result =  await createNotification(id , notification)


   if(result){
    res.status(200).json({ok : true})
   }else{
    res.status(400).json({ok : false})
   }
}}

async function httpGetNotificationCount(req , res){
    const email = res.locals.email
    result = await getNotificationCount(email)
    
    if(result !== false){
        res.status(400).json(result)
    }else{
        res.status(400).json({ok : false})
    }
}

async function httpGetAllNotifications(req , res){
    const email = res.locals.email
    const result=  await getAllNotifications(email)
//    console.log(result)
//    console.log(email)
   console.log("finally here")
    if(result){ 
       console.log("sent!");
        res.status(200).json(result)
    }else{
        res.status(400).json({ok:false})
    }
}


async function httpSearchFreelancer(req, res){
    const name = req.params.name
    const result = await searchFreelancer(name)
    if(result){
        res.status(200).json(result)
    }else{
        res.status(404).json(result)
    }
}

async function httpCheckApplied(req , res){
    console.log("************************")
    console.log("application request to check whether am applied")
    const email  = res.locals.id
    const jobId = req.params.id
    const result = await checkApplied(email , jobId)
    if(result){
        console.log(`applied has already applied ${jobId}`)
        res.status(200).json({ok : true})
    }else{
        console.log(`not applied for this job ${jobId}`)
        res.status(200).json({ok : false})
    }

}


async function httpCheckConnection(req , res){
   
    const id = req.params.id
    const email =res.locals.companyEmail
    console.log("connection request coming")
    const result = await checkConnection(id , email)
    if(result === true){
        res.status(200).json({ok : true})
    }else{
        res.status(200).json({ok : false})
    }
}


async function httpGetAppliedJobs(req , res){
    email = res.locals.email
    console.log("applied jobs requested")
    result = await getAppliedJobs(email)

    console.log(email);
    
    console.log(result)
    if(result){
        console.log("got")
        res.status(200).json(result)
    }else{
        res.status(400).json({ok : false})
    }
    
}

async function httpGetAppliedFreelancer(req , res){
    const freelancerId = req.params.id

    const result = await getAppliedFreelancer(freelancerId) ; 
   
    if(result){
        res.status(200).json(result)
    }else{
        res.status(400).json({ok : false})
    }
}

async function httpGetProfile(req , res){
    const freelancerId = res.locals.id

    const result  = await getProfile(freelancerId)

    if(result !==false){


    const result  = await getProfile(freelancerId)

    if(result !== false){

      return  res.status(200).json(result)
    }else{
        return res.status(400).json({ok  : false})
    }
}}



async function httpUpdateProfile(req, res){
    let changed;
    let exist;
    let response;
    body = req.body
    bodyEmail = body.email
    email = res.locals.email 
    id = res.locals.id
    console.log("request coming")
    
    changed =  email === bodyEmail ? false : true 
  


    const result = await checkEmail(bodyEmail)
    if(changed === false){
        exist = false
    }else if(changed === true & result === 1){
        exist = true
    }else if(changed === true & result ===0){
        exist = false
    }
   
    if(result === false){
        console.log("false")
        return res.status(400).json({ok : "error"})
    }
    if(exist === true){
        console.log("working")
        return res.status(400).json({ok :false})

    }else if(exist ===false){
        
        response = await updateProfile(id , body)
    }
    
   
    
    
    

    if(!exist & response ){
        const token = jwt.sign(
            {email : body.email , name : body.firstName  , department : body.department , id : id} , config.COOKIE_KEY
        )
        console.log("worked")
        jsonFile = await sendAuthentication(id)
        return res.status(200).json(jsonFile)
    }else{
        console.log("not!")
        res.status(400).json({ok : false})
    }



}


async function httpUploadProfile( req, res){
    console.log("success")
    return res.status(201).json({
        ok : true
    })
} 

async function httpUpdatePassword(req, res){
    newPassword = req.body['newPassword']
    oldPassword = req.body['oldPassword']
    id = res.locals.id
    console.log(id);
    checkOldPassword = await isOldPasswordValid(id , oldPassword)

    if(!checkOldPassword){
       return res.status(401).json({ok : false})
    }
    if(checkOldPassword == true){

      await updatePassword(id , newPassword);

      res.status(200).json({ok : true})
    }
        return false
}


async function httpGetPendingFreelancers(req , res){
    result = await getPendingFreelancers()
    console.log("request came here")
    if(result){
   
      return  res.status(200).json(result)
    }
    return res.status(400).json({ok : false})
}
async function httpConfirmFreelancer(req, res){
    id= req.body.id
   
    result = await confirmFreelancer(id)
    if(result){
        console.log("wel")
        return res.status(201).json({ok : true})
    }
  
    return res.status(400).json({ok : false})
}
module.exports = {
    httpConfirmFreelancer,
    httpUpdateProfile, 
    httpGetPendingFreelancers ,
    httpGetProfile , 
    httpGetAppliedFreelancer , 
    httpGetAppliedJobs , 
    httpCheckConnection ,
    httpCheckApplied , 
    httpSearchFreelancer ,  
    httpGetAllNotifications,
    httpGetRandomFreelancers , 
    httpCreateFreelancer , 
    httpDeleteFreelancer , 
    httpGetAllFreelancers , 
    httpLoginFreelancer , 
    httpGetAppliedPeople, 
    httpCreateNotification, 
    httpGetNotificationCount , 
    httpUploadProfile   , 
    httpUpdatePassword

}