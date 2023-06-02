import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/route_names.dart';

class SeeAppliedPeopleButton extends StatelessWidget {
 const SeeAppliedPeopleButton({required this.jobId});
  final String jobId;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton( onPressed: () {
    context.goNamed(RouteNames.applicants, pathParameters: {'jobid': jobId});
   
  }, 
    style: ElevatedButton.styleFrom(
    backgroundColor : Colors.grey[800],
    foregroundColor: Colors.grey, 
  ),
  child: Text("See applied people"),
    
    );
  }
}