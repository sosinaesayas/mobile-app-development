const {createCompany , loginCompany, getPostedJobs} = require("./company.model") 
async function httpCreateCompany(req, res){
    const body = req.body
    const returned  = await createCompany(body);

    if(returned === true){
        res.status(201).json({
            ok : returned
        })
    } else{
        res.status(400).json({
            message : returned
        })
    }
}

async function httpLoginCompany(req, res){
    return await loginCompany(req, res)
}


async function httpGetPostedJobs(req, res){
    companyId = res.locals.companyId
    result = await getPostedJobs(companyId)

   
    if(result){
      
  

      
        res.status(200).json(result)
    }else{
        res.status(400).json({ok : false})
    }
}


module.exports = {
    httpGetPostedJobs,
    httpCreateCompany ,
     httpLoginCompany , 
    }