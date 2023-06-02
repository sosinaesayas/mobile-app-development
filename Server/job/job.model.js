const uuid4 = require("uuid")
const job = require("./job.mongoose")
const { getAppliedFreelancer } = require("../freelancer/freelancer.model")





async function createJob(jobObj){
    if(!jobObj.title || !jobObj.department || !jobObj.description || !jobObj.location   || !jobObj.deadline 
        ){
           
       
            return false            
        }
    jobObj.deadline = new Date(jobObj.deadline)
    jobObj.dateCreated = new Date()



    // jobObj.id = uuid4.v4()
    await job.create(jobObj)
    return true
  

}







async function deleteJobById(job_id){
    console.log(job_id)
    console.log("=======")
    try{
        res = await job.findOne({id : job_id})
        console.log(res)
        result  = await  job.deleteOne({
            id : job_id
        })
        console.log(res)
        console.log(result)
        return true
    }catch(e){
        return false
    }


}

async function applyToJob(job_id , body){
   
    
    
    
    
    try{
       result =  await job.findOneAndUpdate(
            { id: job_id },
            { $push: { personsApplied: body } } ,   {upsert : true}
         )
     console.log(result)
     console.log(`result is ${result}`)
      return result
    

    }
    catch(e){
        console.log(e)
        return false
    }
}




async function getAllJobs(){
    return await job.find({})
}




async function closeJob(id , companyName){
 
    try{


        

         await job.updateOne(
            {
                id : id , 
                 companyName : companyName
            } , 
            {$set : {status : "Closed"}}
        )

        return job.findOne({id : id})
    }
    catch(e){
        console.log(e)
        return false
    }
}


async function openJob(id , companyName){
 
    try{


        

         await job.updateOne(
            {
                id : id , 
                 companyName : companyName
            } , 
            {$set : {status : "Open"}}
        )

        return job.findOne({id : id})
    }
    catch(e){
        console.log(e)
        return false
    }
}

async function getJobByDepartment(department){
    try{
        return await job.find({
            department : department
           }).sort({dateCreated: -1 , status  : -1})
    }
    catch(e){
       
        return false
    }
}


async function getAppliedJobs(email){
   
   
    filter = {
       
        personsApplied: {
          $elemMatch: {
            id: email
          }
        }
      };
   
   
    try{
        result = await job.find(filter);

        console.log(result)
        return result
    }catch(e){
        console.log(e)
        return false
    }
}



async function searchJobs(title){
  


    const pipeline =  [
        {
          $search: {
            index: "Description",
            text: {
              query: title,
              path: ["title" , "description" , "companyName"],
              
            }
          } , 
        
        } , 
        {
            $project : {
                _id : 0 ,
                personsApplied : 0
              } ,
              
        }
      ]
    try {
        const result = await job.aggregate(pipeline)
      
        return result
    } catch (error) {
        console.log(error) 
        return false       
    }

}


async function getJobById(jobId){
console.log("asked me ===================")  
    try {
        result = await job.findOne({
            id : jobId
        }).lean();
      
        return result
    } catch (error) {
        return false
    }
}



async function getAppliedPeople(jobId){

    
    try{
        result = await job.findOne({
            id : jobId
        } , {
            _id : 0 , 
            personsApplied : 1
       
        })
     
        freelancers = []
       for(var i = 0 ; i <result.personsApplied.length ; i++){
            id = result.personsApplied[i]["id"];
            response = result.personsApplied[i]["response"]
                freelancerNew = {}
                //  console.log("-------------")
                // console.log( result.personsApplied[i])
                // sb = {}
                
                // console.log(sb)
                freelancer = await getAppliedFreelancer(id)

                //   freelancer["acceptance"] = result.personsApplied[i]["response"]

            
                // lastName: map['lastName'],
               
                
                // phone: map['phone'],
                // department: map['department'],
               
               
                freelancerNew['description'] = freelancer['description'];
                freelancerNew['email'] = freelancer['email'];
                freelancerNew['firstName'] = freelancer['firstName'];
                freelancerNew['lastName'] = freelancer['lastName'];
                freelancerNew['experience'] = freelancer['experience'];
                freelancerNew['department'] = freelancer['department'];
                freelancerNew['id'] = freelancer['id']
                freelancerNew['acceptance'] = result.personsApplied[i]["response"]
                freelancerNew['phone'] = freelancer['phone']
            console.log("freelancer is")
            console.log(freelancerNew)
            freelancers.push(freelancerNew);
       }
       
      console.log(freelancers)
        return freelancers

    }catch(err){
        console.log(err)
        return false
    }
}



async function acceptFreelancer(jobId , companyName , freelancerId){
    try { 

       
        const result =  await job.updateOne({
            id : jobId , 
            companyName : companyName ,
            "personsApplied.id" : freelancerId

        } , {
            $set : {"personsApplied.$.response":   "Accepted"}
        })
        console.log(result)
       
        return result
    } catch (error) {
        console.log(error)
        return result
    }
}



async function getAppliedJob(jobId){
    try {
        return await job.find({
            id : jobId
        } , {
            _id : 0 , 
            personsApplied : 0
        })
    } catch (error) {
        console.log(error)
        return false
    }
}
module.exports = {
    getAppliedJob , 
    acceptFreelancer ,     
    getAppliedPeople , 
    getJobById, 
    searchJobs , 
    getAppliedJobs , 
    closeJob , 
    openJob,
  //  getPostedJobs , 
    createJob , 
    deleteJobById,
    applyToJob , 
    getAllJobs ,
    getJobByDepartment,
}


