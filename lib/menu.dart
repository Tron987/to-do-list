import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
       
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Other Tools',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Google Calendar'),
              onTap: () {
                // Handle Google Calendar item tap
              },
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text('Evernote'),
              onTap: () {
                // Handle Evernote item tap
              },
            ),
          ],
        ),
      
    );
  }
}