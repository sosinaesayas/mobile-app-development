import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/application/job/bloc/job_event.dart';
import 'package:jobportal/application/job/bloc/job_state.dart';
import 'package:jobportal/presentation/views/job_snippets.dart';

class MyJobs extends StatefulWidget {
  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  @override
  void initState() {
    super.initState();
    requestJobs();
  }

  void requestJobs(){
     // context.read<JobBloc>().add(JobsRequested());
     BlocProvider.of<JobBloc>(context).add(AppliedJobsRequested());
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: BlocBuilder<JobBloc, JobsState>(
        builder: (context, state) {
          
          if (state.status == JobsStatus.requestInProgress ) {
           return  state.appliedjobs.isNotEmpty?  Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.appliedjobs.length,
                    itemBuilder: (context, index) {
                      final job = state.appliedjobs[index];
                      return JobSnippets(job: job);
                    },
                  ),
                ),
                CircularProgressIndicator()
              ],
            ) : CircularProgressIndicator();
          } else if (state.status == JobsStatus.NetworkFailure) {
            
            return state.appliedjobs.isNotEmpty ? Scaffold(
                
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.appliedjobs.length,
                      itemBuilder: (context, index) {
                        final job = state.appliedjobs[index];
                        return JobSnippets(job: job);
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    width: MediaQuery.of(context).size.width,
                    child: Text("Network error!", 

                    style: TextStyle(
                      backgroundColor: Colors.white10,
                      color: Color.fromARGB(255, 232, 222, 222)
                    ),
                    ))
                  
                ],
              ),
            ) : Center(
              child: Column(
                children: [
                 Text("Network Error" , 
                style: TextStyle(
                  fontSize: 18 , 
                  fontWeight: FontWeight.w500 , 
                  color: Colors.amber,), 
                ),
                IconButton(onPressed: (){requestJobs();}
                ,
                 icon: Icon(Icons.arrow_circle_left_outlined))
                
                
                
                ]
              ),
            );

          } else if (state.status == JobsStatus.authenticationFailed) {
            return Text(
              "unauthorized",
              style: TextStyle(color: Colors.white),
            );
          } else if (state.status == JobsStatus.requestSuccess) {
            return
             Column(
              children: [
                Expanded(
                  child: ListView.builder(
                   
                    itemCount: state.appliedjobs.length,
                    itemBuilder: (context, index) {
                      final job = state.appliedjobs[index];
                      
                      return Column(
                        children: [
                          JobSnippets(job: job), 
                          // CheckApplication(jobId: job.id)
                          
                      
                        ],
                       );

                    },
                  ),

                  
                ),


              ],
            );
          } 
            return Text(" ");
        
        },
      ),
    );
  }
}