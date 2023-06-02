import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/application/job/bloc/job_event.dart';
import 'package:jobportal/application/job/bloc/job_state.dart';
import 'package:jobportal/presentation/pages/applied_freelancers.dart';
import 'package:jobportal/presentation/views/deletejobs.dart';
import 'package:jobportal/presentation/views/job_snippets.dart';
import 'package:jobportal/presentation/widgets/close_job.dart';
import 'package:jobportal/presentation/widgets/closed_job.dart';
import 'package:jobportal/presentation/widgets/open_job.dart';


class ListofJobs extends StatefulWidget {
  
  ListofJobs({super.key});

  @override
  State<ListofJobs> createState() => _ListofJobsState();
}


class _ListofJobsState extends State<ListofJobs> {
  @override
  void initState() {
    
    requestPostedJobs();
    super.initState();
  }

void requestPostedJobs(){
    context.read<JobBloc>().add(PostedJobsRequested());
}
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<JobBloc , JobsState>(builder: (context , state){
        if(state.jobs.isEmpty && state.postedjobsrequest == JobsStatus.requestSuccess ){
          return const Center(
           child :  Text("You haven't posted any thing so far. Feel free to post and reach out freealcers")
          );
        }else if(state.jobs.isNotEmpty){
          const   SnackBar(content:   Text( "no network error"));
          return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                   
                    itemCount: state.jobs.length,
                    itemBuilder: (context, index) {
                      final job = state.jobs[index];
                      
                      return Container(
                        
                        
                        child: Column(
                          
                          children: [
                            JobSnippets(job: job), 
                            SizedBox(height: 12,), 
                            SingleChildScrollView(
                            
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  job.status == "Open" ? CloseJob(jobId: job.id) :  OpenJob(jobId: job.id) , 
                                  ElevatedButton( onPressed: () {
                             
                                          Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return  AppliedFreelancers(jobid: job.id,);
                                        },
                                      ),
                                    );
                              
                                                     }, 
                                            style: ElevatedButton.styleFrom(
                                            backgroundColor : Colors.grey[800],
                                            foregroundColor: Colors.grey, 
                                          ),
                                          child: Text("See applied people"),
                                            
                                            ), 
                            
                                            DeleteJob(jobId: job.id)
                                                                      ],),
                            )
                             ],
                         ),
                      );

                    },
                  ),

                  
                ),


              ],
            );
        }else if(state.jobs.isEmpty && state.postedjobsrequest == JobsStatus.NetworkFailure){
           
              return Center(
                child: Text("Can't access your data. please check your connection and try again" , style:  TextStyle(

                  color: Colors.blueGrey
                ),) ,
              );
        };
        return Center(
          child: CircularProgressIndicator(),
        );
    });
  }
}