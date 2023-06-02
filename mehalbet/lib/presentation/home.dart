import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/application/job/bloc/job_state.dart';
import 'package:jobportal/presentation/pages/notifications_page.dart';
import 'package:jobportal/presentation/pages/profile.dart';
import 'package:jobportal/presentation/pages/search_jobs.dart';
import 'package:jobportal/presentation/views/job_card.dart';
import 'package:jobportal/presentation/views/my_job_card.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResults(keyword: keyword),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobBloc(),
      child: Container(
        child: BlocBuilder<JobBloc, JobsState>(
          builder: (context, state) {
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title:  Text(
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
                body: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            "Jobs",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "My jobs",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Notification",
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
                          JobCard(),
                         
                            
                          NotificationsPage(),
                         
                          ProfilePage(),
                        
                         
                         
                          
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
