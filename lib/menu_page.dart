import 'package:romoogoola/common//circular_image.dart';
import 'package:romoogoola/dispaly/add_comic.dart';
import 'package:romoogoola/zoom_scaffold.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romoogoola/provider/user_provider.dart';

class MenuScreen extends StatelessWidget {
  final String imageUrl =
      "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

  final List<MenuItem> options = [
    MenuItem(Icons.search, 'Search'),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? (Brightness.light)
              : Brightness.dark);
    }

    void changeColor() {
      DynamicTheme.of(context).setThemeData(new ThemeData(
          primaryColor: Theme.of(context).primaryColor == Colors.red
              ? Colors.yellow
              : Colors.blue));
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanUpdate: (details) {
        if (details.delta.dx > 6) {
          Provider.of<MenuController>(context, listen: false).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 32,
            right: 32,
            bottom: 8,
            left: MediaQuery.of(context).size.width / 2.9),
        // color: Color(0xff000000),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, top: 52.0, left: 30),
                    child: CircularImage(
                      NetworkImage(imageUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 52.0),
                    child: Text(
                      'Vinit',
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                children: options.map((item) {
                  return ListTile(
                    leading: Icon(
                      item.icon,
                      // color: Colors.white,
                      size: 20,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // color: Colors.white
                      ),
                    ),
                  );
                }).toList(),
              ),
              ListTile(
                onTap: () async {},
                leading: Icon(
                  Icons.notifications_active,
                  // color: Colors.white,
                  size: 20,
                ),
                title: Text('Notification',
                    style: TextStyle(
                      fontSize: 14,
                      // color: Colors.white
                    )),
              ),
              ListTile(
                onTap: () async {},
                leading: Icon(
                  Icons.chat,
                  // color: Colors.white,
                  size: 20,
                ),
                title: Text('Chat',
                    style: TextStyle(
                      fontSize: 14,
                      // color: Colors.white
                    )),
              ),
              ListTile(
                onTap: () async {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AddComic()));
                },
                leading: Icon(
                  Icons.event,
                  // color: Colors.white,
                  size: 20,
                ),
                title: Text('Add',
                    style: TextStyle(
                      fontSize: 14,
                      // color: Colors.white
                    )),
              ),
              Spacer(),
              ListTile(
                onTap: () async {
                  await user.signOut();
                },
                leading: Icon(
                  Icons.keyboard_backspace,
                  // color: Colors.white,
                  size: 20,
                ),
                title: Text('Logout',
                    style: TextStyle(
                      fontSize: 14,
                      // color: Colors.white
                    )),
              ),
              ListTile(
                onTap: () {
                  changeBrightness();
                },
                leading: Icon(
                  Icons.wb_sunny,
                  // color: Colors.white,
                  size: 20,
                ),
                title: Text('Change Theme',
                    style: TextStyle(
                      fontSize: 14,
                      // color: Colors.white
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
