const express = require("express")
const { checkCompany } = require("../components/checkCompany")

const  {
    httpCreateCompany ,
     httpLoginCompany, 
     httpGetPostedJobs, 
    }  = require("./company.controller")

const adminRouter = express.Router() 

 
 
adminRouter.post('/login' , httpLoginCompany)
// companyRouter.post('/signin' , httpCreateCompany)
// companyRouter.get('/jobsposted' , checkCompany , httpGetPostedJobs)


module.exports = companyRoute