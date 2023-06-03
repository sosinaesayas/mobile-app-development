const express = require("express")
const Freelancer = require("./freelancer.mongoose")
const {passport} = require("./../app")
const {
    httpCheckConnection, 
    httpGetAllFreelancers ,
    httpUpdateProfile , 
    httpDeleteFreelancer  , 
    httpLoginFreelancer ,
    httpCreateFreelancer , 
    httpGetAppliedPeople, 
    httpGetRandomFreelancers,
    httpCreateNotification , 
    httpGetNotificationCount,
    httpGetAllNotifications, 
    httpSearchFreelancer, 
    httpCheckApplied, 
    httpGetAppliedJobs,
    httpGetAppliedFreelancer , 
    httpGetProfile,
    httpUploadProfile,
    httpUpdatePassword
} = require("./freelancer.controller")
const {checkCompany} = require("../components/checkCompany")
const checkLoggedIn = require("../checkLoggedin")
const multer = require('multer')


const storage = multer.diskStorage({
    destination : function(req , res, cb){
        cb(null , "./uploads/")
    } , 
    filename : function(req, res, cb){
        cb(null , res.locals.freelancerId)

    }
})

const upload = multer({
    storage : storage , 
    limits: {
        fileSize: 1024 * 1024 * 2 
      } 
    
}).single("image")

function print(){
    console.log("request")
}



const freelancerRouter = express.Router()

//freelancerRouter.get("/" , consoler , httpGetAllFreelancers)
freelancerRouter.get("/notify" , checkLoggedIn  , httpGetNotificationCount)

freelancerRouter.get("/notifications"  , checkLoggedIn , httpGetAllNotifications)

freelancerRouter.get("/appliedjobs" ,  checkLoggedIn , httpGetAppliedJobs ) 

freelancerRouter.get("/random" , checkCompany , httpGetRandomFreelancers)

freelancerRouter.post("/updatepassword" , checkLoggedIn , httpUpdatePassword)

freelancerRouter.get("/profile" , checkLoggedIn  , httpGetProfile)

freelancerRouter.get("/appliedpeople/:id" , checkCompany , httpGetAppliedPeople)

freelancerRouter.get("/appliedfreelancer/:id" , checkCompany , httpGetAppliedFreelancer)
 
freelancerRouter.get("/checkapplied/:id" , checkLoggedIn , httpCheckApplied)
 
freelancerRouter.get("/search/:name"  , httpSearchFreelancer)

freelancerRouter.get("/checkconnection/:id" , checkCompany , httpCheckConnection)

freelancerRouter.post("/signin" , httpCreateFreelancer)  

freelancerRouter.post("/login" , httpLoginFreelancer)

freelancerRouter.post("/upload",print  , upload, httpUploadProfile )

freelancerRouter.post("/createnotification/:id" , checkCompany , httpCreateNotification)
  
freelancerRouter.post("/updateprofile" , checkLoggedIn , httpUpdateProfile);


freelancerRouter.post("/deleteAccount" , checkLoggedIn , httpDeleteFreelancer)


module.exports = {freelancerRouter} 