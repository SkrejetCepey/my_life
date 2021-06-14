import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_life/pages/goals_page.dart';

import 'desire_page.dart';

class ChooserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Создание цели или привычки"),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          itemExtent: 50.0,
          children: [
            ElevatedChooserPageButton(
              title: "Создание привычки",
              iconData: FontAwesomeIcons.calendarAlt,
              callback: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DesirePage.add()));
              },
            ),
            ElevatedChooserPageButton(
              title: "Создание цели",
              iconData: FontAwesomeIcons.calendarCheck,
              callback: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GoalsPage.add()));
              },
            ),
            ListTile(
              title: Text("или выберите из популярных категорий:"),
            ),
            ListTile(
              title: Center(child: Text("в разработке....")),
            ),
          ],
        ),
      ),
    );
  }
}

class ElevatedChooserPageButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function callback;

  ElevatedChooserPageButton(
      {@required this.title, @required this.iconData, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      title: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ))),
        onPressed: callback,
        child: Row(
          children: [
            Icon(iconData, color: Colors.black54),
            SizedBox(
              width: 20.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
