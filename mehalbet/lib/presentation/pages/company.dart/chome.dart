import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/user/bloc/user_bloc.dart';
import 'package:jobportal/application/user/bloc/user_state.dart';
import 'package:jobportal/presentation/pages/company.dart/company_profile.dart';
import 'package:jobportal/presentation/pages/company.dart/randomfreelancers.dart';
import 'package:jobportal/presentation/pages/post_jobs.dart';
import 'package:jobportal/presentation/pages/postedjobs.dart';




class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController(

  );

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }
   void _onSearchButtonClicked() {
    final String keyword = _searchController.text;
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SearchResults(keyword: keyword),
    //   ),
    // );
  }
   late ScaffoldMessengerState scaffoldMessenger;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return BlocProvider(
       
      create: (context) => FreelancerBloc(),
      child: Container(
        child: BlocBuilder<FreelancerBloc, FreelancerState>(
          builder: (context, state) {
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                 key: scaffoldMessengerKey,
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title: _isSearching
                      ? TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'search jobs',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 215, 187, 185),
                            ),
                          ),
                        )
                      : Text(
                          'አfalagi',
                          style: TextStyle(
                            color: Color(0xFF27AE60),
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
                body: const Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            "Freelancers",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Posted Jobs",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                        
                        Tab(
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Post job",
                            style: TextStyle(
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
                          Freelancers(),
                          PostedJobs(),
                           Logout(),
                          PostJobWidget(),
                          
                        
                         
                         
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
