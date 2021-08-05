import 'package:flutter/material.dart';
import 'package:spot_manager/inApp_selections/selection_tab.dart';

class CategoryViewpage extends StatelessWidget {
  final String title;
  final String icon;
  final int index;

  const CategoryViewpage({this.index, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.all(10),
              shadowColor: Theme.of(context).accentColor,
              elevation: 6,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    icon == null
                        ? Container()
                        : Container(
                            child: Image.network(
                              icon,
                              fit: BoxFit.fitHeight,
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                    ListTile(
                      title: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.info,
                          color: Theme.of(context).accentColor),
                      title: Text(
                        'Title:',
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        title,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: Text('Edit'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectionTab(
                          index: index,
                          name: title,
                          image: icon == null ? null : icon),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
