// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:jobportal/application/close_job_bloc/close_job_bloc.dart';
// import 'package:jobportal/application/close_job_bloc/close_job_state.dart';
// import 'package:jobportal/route_names.dart';
// import 'package:jobportal/store/close_job_bloc/close_job_event.dart';
// import 'package:path/path.dart';



// class CloseJobBtn extends StatefulWidget {
//     CloseJobBtn({required this.jobId});
//     final String jobId;
//   @override
//   State<CloseJobBtn> createState() => _CloseJobBtnState();
// }



// class _CloseJobBtnState extends State<CloseJobBtn> {
//   @override
// void requestJobClose(){
// //  context.read<CloseJobBloc>()<CloseJobBloc>().add(closeJobRequested());

// }

//   Widget build(BuildContext context) {
//     return BlocBuilder<CloseJobBloc, CloseJobState>(
//       builder: (context, state) {
//         if(state.status == closeJobStatus.requestSuccess){
//           const SnackBar(content: Text("Successfully closed the job"));
//           return ElevatedButton(onPressed: (){}, child: const Text("Closed"));
//         }else if(state.status == closeJobStatus.requestInProgress){
//           return ElevatedButton(onPressed: (){}, child: const Text("Closing ..."));
//         }else if(state.status == closeJobStatus.unauthorised){
//            WidgetsBinding.instance.addPostFrameCallback((_) {
//               context.goNamed(RouteNames.login);
//            });
//         }else if(state.status == closeJobStatus.requestFailed || state.status == closeJobStatus.unknown){
//              ElevatedButton(onPressed: (){}, child: const Text("Close"));
//         }
//         return const SizedBox(height: 10,);
//       },
//     );
//   }
// }