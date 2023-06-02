import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/application/job/bloc/job_state.dart';
class SearchResults extends StatelessWidget {
  SearchResults({required this.keyword});
  final String keyword;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<JobBloc>(
        create: (context) => JobBloc(),
        //child: Login(),
                child: Results(keyword: this.keyword)
      ),
    );
  }
}



class Results extends StatefulWidget {
  const Results({required this.keyword});
  final String keyword;

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => JobBloc(),
      child:  BlocBuilder<JobBloc, JobsState>(
        builder: (context, state) {
          if (state.status == JobsStatus.requestInProgress) {
            return Scaffold(
              appBar : AppBar(
                title : Text((widget.keyword))
              ), 
              body : CircularProgressIndicator()
            );
          } else if (state.status == JobsStatus.NetworkFailure) {
            return Container(
              child: Text(
                "network failure",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (state.status == JobsStatus.authenticationFailed) {
            return Center(
              child: Text("unauthorized",
               style: TextStyle(color: Colors.white),
              ),
             
            );
          } else if (state.status == JobsStatus.requestSuccess) {
            return Scaffold(
              appBar : AppBar(
                title : Text(widget.keyword)), 
                body : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.jobs.length,
                    itemBuilder: (context, index) {
                      final job = state.jobs[index];
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                job.title,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),Text(
                                job.description,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                job.status,
                               
                              ),
                              Text(
                                job.companyName
                              
                              ),
                              Text(
                                job.description,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ));
            
          
              
            
          } else {
            return Center(
              child : Text( "Nothing to show")
             );
          }
        },
      ),
    );
  }
      
  }
