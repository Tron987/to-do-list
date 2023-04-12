import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/addTask.dart';
import 'package:todolist/editTask.dart';
import 'package:todolist/menu.dart';
import 'package:intl/intl.dart';

class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _children = [    HomeTab(),    GroupsTab(),    TimetableTab(),    ProfileTab(),  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Menu(),
      appBar: AppBar(
        title: Text('To-Do List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, color: Colors.white),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule, color: Colors.white),
            label: 'Timetable',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded, color: Colors.white),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddActivityPage()),
          );
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class HomeTab extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> deleteDocument(String docId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('todos')
        .doc(docId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('todos')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
          color: Colors.white,
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              DateTime time = data['time'].toDate();
              String formattedTime = DateFormat('hh:mm a').format(time);
              return ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.purple,
                  child: ListTile(
                    leading: Text(
                      formattedTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      data['taskName'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTask(todo: document),
      ),
    );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                            deleteDocument(document.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}




class GroupsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Groups Tab'),
    );
  }
}

class TimetableTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Timetable Tab'),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Tab'),
    );
  }
}
