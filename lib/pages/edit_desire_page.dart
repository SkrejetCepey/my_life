import 'package:flutter/material.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/desire.dart';

class EditDesirePage extends StatelessWidget{

  final Desire desire;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DesiresListCubit cubit;

  EditDesirePage({Key key, @required this.desire, @required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditDesirePage'),
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
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            FlatButton(
              child: Text('Delete'),
              color: Colors.red,
              onPressed: () async {
                await NotificationDialog.showNotificationDialog(context, 'Are you sure about deleting ${desire.title} ?', _deleteDesire);
              },
            ),
            Spacer(),
            FlatButton(
              child: Text('Update'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  await cubit.update(desire);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteDesire(BuildContext context) async {
    await cubit.delete(desire);
    Navigator.pop(context);
    Navigator.pop(context);
  }

}