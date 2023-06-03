const 
    {
        createJob , 
       getAppliedJobs ,
        deleteJobById,
        applyToJob , 
        getPostedJobs,
        getAllJobs,    
        closeJob ,     
        openJob, 
        getJobByDepartment , 
        searchJobs,
        getJobById,
        getAppliedPeople,
        acceptFreelancer,
        getAppliedJob
      
       
    }
 = require("./job.model")

 const {addAppliedJob , checkApplied, getFreelancerByEmail, createNotification, getAppliedFreelancer} = require("../freelancer/freelancer.model")

const uuid = require("uuid")
const { postJob } = require("../company/company.model")
const { httpGetAppliedFreelancer } = require("../freelancer/freelancer.controller")


async function httpCreateJob(req , res){
    console.log("creating a job........")
    const companyEmail = res.locals.companyEmail
    const id = uuid.v4()
    const body  = req.body
    body['companyName'] = res.locals.companyName
    body['id'] = id

   const value =  await createJob(body)
   const register = await postJob(companyEmail  , id)
 
   if(value & register){

console.log("working");
    res.status(200).json({created : true})
   }else{
    res.status(409).json({created : false})
   }
}



function httpGetAppliedPeople(req , res){
    // TODO
}


async function  httpDeleteJobById(req, checkCompany , res){
    //TODO
    id = +req.params.id
    result = await deleteJobById(id)    
    if(result){
       return res.status(200).json({ok : true})
    }
    return res.status(400).json({ok : false})
}

async function httpGetAllJobs(req, res){
    console.log("sdfffffff")
    const result = await getAllJobs()

    return res.status(200).json(result)
}



async function httpGetPostedJobs(req ,  res){

    // Give id for company too!


    // const companyEmail = res.locals.companyEmail
    // return res.status(201).json(jobs)
}



async function httpCloseJob(req, res){ //should be modified so that it uses company email instead of name for security reasons
    const email = res.locals.companyEmail
    const id = req.params.id 
    const companyId = res.locals.campanyId
    const name = res.locals.companyName
    const value = await closeJob(id, name)
    if(value){
        console.log(value)
        res.status(200).json(value)
    }else{ 
        console.log("failed")
        res.status(400).json({message : "Operation failed!"})
    }
}   


async function httpOpenJob(req, res){ //should be modified so that it uses company email instead of name for security reasons
  
    const id = req.params.id 
     const name = res.locals.companyName
    const value = await openJob(id, name)
    if(value){
        console.log(value)
        res.status(200).json(value)
    }else{ 
        console.log("failed")
        res.status(400).json({message : "Operation failed!"})
    }
}  



async function httpGetJobByDepartment(req ,  res){
    const value = await getJobByDepartment(res.locals.department)
    if(value){
        res.status(200).json(value)
    }   
    else{
        res.status(404).json({ok : false})
    }
}


async function httpGetDeptJobs(req , res){
 
    const value = await getJobByDepartment(req.params.department)
    if(value){
        res.status(200).json(value)
    }   
    else{
        res.status(404).json({ok : false})
    }    
}

async function httpApplyToJob(req, res){
    let result;
    let add;  
    console.log("application request is coming")

    email = req.body.email ;
    jobId = req.body.jobId
    freelancerId= req.body.userId
    console.log(freelancerId)
    console.log("========================")
    console.log(req.body)
    
  
   
    const application = {id : freelancerId  ,  response : "Pending"}

    
    
    
     
    
   
  
  
  
   const checkApply = await checkApplied(freelancerId , jobId)
    

    if (!checkApply){
     
        result  =  await applyToJob(jobId , application)
        add = await addAppliedJob(freelancerId , jobId)
        console.log("****************")
        console.log(result)
        console.log(add)
    }
    if(result && add){
        console.log("applied")
        res.status(200).json({ok: true})
    }else{ 
        console.log(result)
        console.log(add)
        console.log("failed")
        res.status(400).json({ok : false})
    }
} 





async function httpGetAppliedJobs(req , res){
   
    
    const email = res.locals.email
    const id = res.locals.freelancerId
        
        
    console.log(email);
    console.log("called get apploed jobs")
        const result = await getAppliedJobs(id)
        console.log(result)

        if(result){
            console.log(result)
            res.status(200).json(result)
        }
        else{
            console.log("no applied jobs")
            res.status(400).json({ok : false})
        }
}

async function httpSearchJobs(req ,res){
    const title = req.body.title
    const result = await searchJobs(title)
  

    
    if(result){
        res.status(200).json(result)
    }else{
        res.status(400).json({ok : false})
    }
} 

async function httpGetAppliedPeople(req, res){
    jobId = req.params.id

   var freelancersList  = []
    
    result = await getAppliedPeople(jobId)
    console.log("here") 
    console.log(result)
    if(result){
        
  
       
       return res.status(200).json(result) 
    }else{
       return  res.status(404).json({})
    }
}


async function httpAcceptFreelancer(req , res){
    companyEmail = res.locals.companyEmail
    companyName = res.locals.companyName
    body = req.body
  
    
    jobId = body['jobId']
    freelancerId = body['freelancerId'] 
    body['contain']['companyName'] = companyName
    body['contain']['email'] =companyEmail
    body['contain']['unread'] = true 
    const contain = body['contain']
    console.log("------request ----")
   
    
    result  = await acceptFreelancer(jobId  , companyName , freelancerId)

    if(result){
        await createNotification(freelancerId , contain)
        return res.status(200).json({ok : true})
    }else{
        return res.status(400).json({ok : false})
    }
}

async function httpGetJobById(req, res){
    id = req.params.id

    result = await getJobById(id)

    if(result){
        return res.status(200).json(result)
    }else{
        return res.status(400).json(result)
    }
}

async function httpGetAppliedJob(req , res){
    id = req.params.id

    result = await getAppliedJob(id)

    if(result){
        return res.status(200).json(result)
    }else{
        return res.status(400).json(result)
    }
}


async function httpDeleteJob(req  , res){
    id = req.params.jobid
    console.log("here")
    result = await deleteJobById(id)
    console.log(result)
    if(result){
       return res.status(200).json({ok : true})
    }
    return res.status(400).json({ok : false})
}
module.exports = {
    httpGetAppliedJob ,
    httpGetJobById , 
    httpAcceptFreelancer,
    httpGetAppliedPeople , 
    httpApplyToJob , 
    httpCloseJob , 
    httpOpenJob,
    httpGetPostedJobs,
    httpCreateJob , 
    httpDeleteJobById , 
    httpApplyToJob , 
    httpGetAllJobs,
    httpGetJobByDepartment,
    httpGetAppliedJobs,
    httpSearchJobs, 
    httpGetDeptJobs , 
    httpDeleteJob
}