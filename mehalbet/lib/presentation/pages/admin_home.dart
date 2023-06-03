import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:jobportal/presentation/views/job_card.dart';
import 'package:jobportal/presentation/views/pending_freelancers.dart';
import 'package:jobportal/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController(

  );

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }
   

  @override
  Widget build(BuildContext context) {
    return 
     Scaffold(
      body:  Container(
        
        
          child :  DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title:  Text(
                          'አfalagi',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                            letterSpacing: 2.0,
                          ),
                        ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _toggleSearch,
                      color: Colors.white,
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            "Freelancers",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                        
                        Tab(
                          child: Text(
                            "Companies",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                          Tab(
                          child: Text(
                            "Profile",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                     
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          PendingFreelancers() ,
                          Text("pageTwo"),
                          Center(
                            child: ElevatedButton(
                              onPressed: ()async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.clear();
                                context.goNamed(RouteNames.login);
                              }, 
                              child: Text(
                                "Logout"
                              )),
                          )
                       
                         
                         
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            ),
     );
          }
      
      
  }
