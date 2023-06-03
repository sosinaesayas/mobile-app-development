import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_bloc.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_bloc.dart';
import 'package:jobportal/application/signup_bloc/signup_bloc.dart';
import 'package:jobportal/infrastructure/authentication/util/check_login.dart';
import 'package:jobportal/presentation/login.dart';
import 'package:jobportal/presentation/home.dart';
import 'package:jobportal/presentation/pages/applied_freelancers.dart';
import 'package:jobportal/presentation/pages/company.dart/chome.dart';
import 'package:jobportal/presentation/pages/company.dart/company_signup.dart';
import 'package:jobportal/presentation/pages/security.dart';
import 'package:jobportal/presentation/pages/sign_up.dart';
import 'package:jobportal/route_names.dart';

class JobPortalApp extends StatefulWidget {
  const JobPortalApp({super.key});

  @override
  State<JobPortalApp> createState() => _JobPortalAppState();
}

// class _JobPortalAppState extends State<JobPortalApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider<JobBloc>(
//         create: (context) => JobBloc(),
//         //child: Login(),
//                 child: Home(),
//       ),
//     );
//   }
// }

class _JobPortalAppState extends State<JobPortalApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
      redirect: (context, state) async {
        if (await isFreelancer() == true) {
          return "/home";
        } else if (await isCompany() == true) {
          return "/chome";
        }
      },
      initialLocation: "/login",
      routes: [
        GoRoute(
            name: RouteNames.signup,
            path: "/signup",
            builder: (context, state) => BlocProvider<SignupBloc>(
                  create: (context) => SignupBloc(),
                  child: FreelancerSignup(),
                )),
            
        GoRoute(
            name: RouteNames.comapanySignup,
            path: "/companysignup",
            builder: (context, state) => BlocProvider<SignupBloc>(
                  create: (context) => SignupBloc(),
                  child: CompanySignup(),
                )),
        GoRoute(
            name: RouteNames.login,
            path: "/login",
            builder: (context, state) => BlocProvider<AuthBloc>(
                  create: (context) => AuthBloc(),
                  child: Login(),
                )),
        GoRoute(
            name: RouteNames.home,
            path: "/home",
            builder: (context, state) => MultiBlocProvider(providers: [
                  BlocProvider<JobBloc>(
                    create: (context) => JobBloc(),
                  ),
                  BlocProvider<ProfileBloc>(
                    create: (context) => ProfileBloc(),
                  )
                ], child: const Home())),
        GoRoute(
          name: RouteNames.chome, path: "/chome",

          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider<JobBloc>(
                create: (context) => JobBloc(),
              ),
              BlocProvider<ProfileBloc>(
                create: (context) => ProfileBloc(),
              ),
            ],
            child: CompanyHome(), 
          )
          
          ),

          // routes: [

          // ],

        GoRoute(
          name: RouteNames.applicants,
          path: '/applicants/:jobid',
          builder: (context, state) {
            return AppliedFreelancers(
              jobid: state.queryParameters['jobid']!,
            );
          },
        ),
      ]);
}
