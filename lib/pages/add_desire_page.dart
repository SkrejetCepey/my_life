import 'package:flutter/material.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/db/db_driver.dart';
import 'package:my_life/models/desire.dart';

class AddDesirePage extends StatelessWidget{

  final Desire _desire = Desire();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddDesirePage'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: SimpleAbstractFormField(model: _desire, iconData: Icons.title, property: 'title'),
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
              child: Text('Save'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  await DBDriver.db.create(_desire);
                }
                print(await DBDriver.db.getAll());
              },
            ),
          ],
        ),
      ),
    );
  }
}