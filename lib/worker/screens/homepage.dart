import 'package:flutter/material.dart';
import 'package:migrantworker/login.dart';
import 'package:migrantworker/worker/screens/exchange_contractor.dart';
import 'package:migrantworker/worker/screens/my_contractor.dart';
import 'package:migrantworker/worker/screens/notification.dart';
import 'package:migrantworker/worker/screens/profile.dart';
import 'package:migrantworker/worker/screens/edit_profile.dart';
import 'package:migrantworker/worker/screens/search_contractor.dart';
import 'package:migrantworker/worker/screens/view_current_job.dart';

class WorkerHome extends StatefulWidget {
  const WorkerHome({super.key});

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Notification();
      } else if (index == 2) {
        currentjob();
      }
    });
  }

  void Notification() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return WorkerNotificationHub(
          toggle: false,
        );
      },
    ));
  }

  void currentjob() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const ViewCurrentJobPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    double widthFactor = MediaQuery.of(context).size.width;
    double heightFactor = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(heightFactor * 0.17), // Custom app bar height
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                top: heightFactor * 0.03,
                left: widthFactor * 0.04,
                right: widthFactor * 0.04,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.green,
                            size: widthFactor * 0.12,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                      Text(
                        "Migrant Connect",
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: widthFactor * 0.07,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.green,
                          size: widthFactor * 0.15,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const WorkerProfile();
                            },
                          ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: heightFactor * 0.02),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.green),
                      hintText: "What are you looking for?",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widthFactor * 0.03),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: ProfileMenu(widthFactor: widthFactor),
        body: Padding(
          padding: EdgeInsets.all(widthFactor * 0.04),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                height: heightFactor * 0.15,
                margin: EdgeInsets.only(bottom: heightFactor * 0.02),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[100],
                  borderRadius: BorderRadius.circular(widthFactor * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.category,
                      size: widthFactor * 0.12,
                      color: Colors.green,
                    ),
                    SizedBox(width: widthFactor * 0.02),
                    Text(
                      "Card ${index + 1}",
                      style: TextStyle(
                        fontSize: widthFactor * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: Colors.green,
              ),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.green,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.work,
                color: Colors.green,
              ),
              label: "Current Job",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightGreen,
          onTap: _onItemTapped,
        ),
        floatingActionButton: SizedBox(
          height: widthFactor * 0.15,
          width: widthFactor * 0.15,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const ContractorSearchPage();
                },
              ));
            },
            shape: const CircleBorder(),
            backgroundColor: Colors.lightGreen,
            child: Icon(
              Icons.search,
              size: widthFactor * 0.09,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final double widthFactor;
  const ProfileMenu({super.key, required this.widthFactor});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widthFactor * 0.8,
      child: Container(
        color: Colors.green.shade100,
        padding: EdgeInsets.symmetric(
          horizontal: widthFactor * 0.05,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: widthFactor * 0.13,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.person,
                  size: widthFactor * 0.13,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Jais Roy',
                style: TextStyle(
                  fontSize: widthFactor * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const LogIn();
                    },
                  ));
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('My Account'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const WorkerProfile();
                        },
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.work),
                    title: const Text('My Contractor'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const MyContractor();
                        },
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.thumb_up),
                    title: const Text('Responses'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return WorkerNotificationHub(
                            toggle: true,
                          );
                        },
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notification Hub'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return WorkerNotificationHub(
                            toggle: false,
                          );
                        },
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const EditWorkerProfile();
                        },
                      ));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ViewCurrentJobPage();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              child: const Text('View Current Job'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ContractorExchangePage();
                  },
                ));
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              child: const Text(
                'Contractor Change Request',
                style: TextStyle(color: Colors.green),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'About\n~',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
