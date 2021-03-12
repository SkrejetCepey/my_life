import 'package:flutter/material.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/desire.dart';

enum _variantsDesirePage {
  add,
  edit
}

class DesirePage extends StatelessWidget{

  final Desire desire;
  final DesiresListCubit cubit;
  final String pageTitle;
  final _variantsDesirePage selectedPage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DesirePage.add({Key key, @required this.cubit}) :
        desire = Desire(), pageTitle = 'AddDesirePage',
        selectedPage = _variantsDesirePage.add, super(key: key);

  DesirePage.edit({Key key, @required this.cubit, this.desire}) :
        pageTitle = 'EditDesirePage',
        selectedPage = _variantsDesirePage.edit, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: SimpleAbstractFormField(model: desire, iconData: Icons.title, property: 'title'),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Row(
          children: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            Builder(
              builder: (BuildContext context) {
                if (selectedPage == _variantsDesirePage.add) {
                  return _addUniqueBottomStaff(context);
                } else if (selectedPage == _variantsDesirePage.edit) {
                  return _editUniqueBottomStaff(context);
                } else {
                  return Text('Something goes wrong :C');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _addUniqueBottomStaff(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Spacer(),
          TextButton(
            child: Text('Save'),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _addDesire(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _editUniqueBottomStaff(BuildContext context) {
    final ButtonStyle enabledStyle = ButtonStyle(foregroundColor: MaterialStateProperty.resolveWith((_) => Colors.redAccent));
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Spacer(),
          TextButton(
            child: Text('Delete'),
            style: enabledStyle,
            onPressed: () async {
              await NotificationDialog.showNotificationDialog(context, 'Are you sure about deleting ${desire.title} ?', _deleteDesire);
            },
          ),
          Spacer(),
          TextButton(
            child: Text('Update'),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _updateDesire(context);
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> _addDesire(BuildContext context) async {
    await cubit.add(desire);
    Navigator.pop(context);
  }

  Future<void> _updateDesire(BuildContext context) async {
    await cubit.update(desire);
    Navigator.pop(context);
  }

  Future<void> _deleteDesire(BuildContext context) async {
    await cubit.delete(desire);
    Navigator.pop(context);
    Navigator.pop(context);
  }

}