const express = require("express")
const jobRouter = express.Router()
const {checkCompany} = require("../components/checkCompany")
const checkLoggedin = require("../checkLoggedin")
const {httpGetJobById,  httpAcceptFreelancer , httpDeleteJob , httpGetDeptJobs,  httpSearchJobs , httpGetAppliedJobs  ,  httpApplyToJob,  httpCreateJob , httpGetAllJobs , httpGetPostedJobs , httpCloseJob , httpGetJobByDepartment, httpGetAppliedPeople, httpGetAppliedJob, httpOpenJob} = require("./job.controller")

function notify(req , res , next){
    console.log("oisdvdfdf")
    next()
}


jobRouter.get("/jobs" ,  httpGetAllJobs)



jobRouter.get("/postedjobs" , checkCompany ,  httpGetPostedJobs)

jobRouter.get("/departmentjob" , checkLoggedin , httpGetJobByDepartment)

jobRouter.get("/department/:department" , checkLoggedin , httpGetDeptJobs)

jobRouter.get("/appliedjobs" , checkLoggedin , httpGetAppliedJobs)

jobRouter.get("/appliedpeople/:id" , checkCompany , httpGetAppliedPeople)

jobRouter.get("/appliedjob/:id" , checkLoggedin , httpGetAppliedJob)

jobRouter.get("/postedjob/:id" , checkCompany , httpGetJobById )

jobRouter.patch("/closejob/:id" , checkCompany , httpCloseJob )

jobRouter.patch("/openjob/:id" , checkCompany, httpOpenJob)

jobRouter.post("/postjob" , checkCompany , httpCreateJob)

jobRouter.post("/applytojob" , checkLoggedin , httpApplyToJob)
 
jobRouter.post("/searchjob" , checkLoggedin , httpSearchJobs) 

jobRouter.post("/acceptfreelancer" , checkCompany ,httpAcceptFreelancer )

jobRouter.get("/deletejob/:jobid" , checkCompany , httpDeleteJob)
module.exports = {jobRouter}