import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/inApp_selections/add_app_available_locations.dart';
import 'package:spot_manager/inApp_selections/selection_tab.dart';
import 'package:spot_manager/models/models.dart';
import 'package:spot_manager/pages/category_view_page.dart';

class ViewCategories extends StatefulWidget {
  final Models model;
  final String title;
  final List content;
  final String collectionName;
  final Function function;
  final int index;
  final bool noIcon;

  ViewCategories(
      {this.noIcon,
      @required this.index,
      @required this.function,
      @required this.model,
      @required this.title,
      @required this.content,
      @required this.collectionName});

  @override
  _ViewCategoriesState createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  fetch() {
    if (widget.collectionName == null) {
      widget.function();
    } else {
      widget.function(widget.collectionName);
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Widget listBuilder(int index, Models model, List content) {
    fetch();
    Container _border = new Container(
      width: double.infinity,
      height: 1.0,
      color: Theme.of(context).primaryColor,
    );
    return Column(children: [
      ListTile(
        leading: widget.noIcon == true
            ? Container()
            : CircleAvatar(
                backgroundImage: NetworkImage(content[index].icon),
              ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget.index == null &&
                        widget.collectionName == null
                    ? AddAvailableLocation(content[index].area)
                    : SelectionTab(
                        index: widget.index,
                        name: content[index].title,
                        image:
                            widget.noIcon == true ? null : content[index].icon),
              )),
        ),
        title: Text(
          content[index].title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryViewpage(
                  index: widget.index,
                  title: content[index].title,
                  icon: widget.noIcon == true ? null : content[index].icon,
                ),
              ));
        },
      ),
      _border,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
      return Container(
        child: widget.content.isEmpty
            ? Center(
                child: Text('Nothing yet'),
              )
            : ListView.builder(
                itemCount: widget.content.length,
                itemBuilder: (context, index) {
                  return listBuilder(index, model, widget.content);
                },
              ),
      );
    });
  }
}

class ViewAllAvailableLocations extends StatelessWidget {
  final Models model;

  const ViewAllAvailableLocations({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View available locations'),
      ),
      body: ViewCategories(
        title: 'Available Locations',
        function: model.getAvailableLocations,
        content: model.availableLocations,
        model: model,
        index: null,
        collectionName: null,
        noIcon: true,
      ),
    );
  }
}
