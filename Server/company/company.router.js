const express = require("express")
const { checkCompany } = require("../components/checkCompany")

const  {
    httpCreateCompany ,
     httpLoginCompany, 
     httpGetPostedJobs, 
    }  = require("./company.controller")

const companyRouter = express.Router() 

 
 
companyRouter.post('/login' , httpLoginCompany)
companyRouter.post('/signin' , httpCreateCompany)
companyRouter.get('/jobsposted' , checkCompany , httpGetPostedJobs)


module.exports = companyRouter