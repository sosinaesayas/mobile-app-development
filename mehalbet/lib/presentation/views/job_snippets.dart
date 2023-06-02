
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobportal/domain/job/model/job_model.dart';

class JobSnippets extends StatelessWidget {
  const JobSnippets({required this.job});
  final Job job;
DateTime convertStringToDate(String dateString) {
  final parts = dateString.split('/');
  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse(parts[2]);

  return DateTime(year, month, day);
}
String formatDate(DateTime date) {
  final formatter = DateFormat('MMMM dd, yyyy');
  return formatter.format(date);
}
  @override
  Widget build(BuildContext context) {
   
    return  Container(
      color: Color.fromARGB(255, 222, 219, 230),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("${this.job.title} " , style: const TextStyle(
              fontSize: 15 , 
              fontWeight: FontWeight.w700, 
              color: Color.fromARGB(255, 16, 13, 13) , 
            ),) , 
            Text("Job status :  ${this.job.status}" , style: TextStyle(
                  fontWeight: FontWeight.w400 ,
                  fontSize: 13, 
                  color: Colors.grey[800]
            ),), 
           Text("Posted by : ${this.job.companyName}" ,style: TextStyle(
                  fontWeight: FontWeight.w100 ,
                  fontStyle: FontStyle.italic,
                  fontSize: 13, 
                  color: Colors.grey[800])),
            Text("Description : ${this.job.description}" , style: TextStyle(
                  fontWeight: FontWeight.w200 ,
                  fontStyle: FontStyle.italic,
                  fontSize: 13, 
                  color: Colors.grey[800]
            ) ), 
            Text("Deadline: ${DateTime.parse(job.deadline)}" ,style: TextStyle(
                  fontWeight: FontWeight.w100 ,
                  fontStyle: FontStyle.italic,
                  fontSize: 13, 
                  color: Colors.grey[800]
            )),
           Text("Location : ${job.location}" , style: TextStyle(
                  fontWeight: FontWeight.w100 ,
                  fontStyle: FontStyle.italic,
                  fontSize: 13, 
                  color: Colors.grey[800]) )


            
            
             ],
        ),
      ),
    );
  }
}