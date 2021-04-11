import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/custom_widgets/date_time_picker.dart';
import 'package:my_life/custom_widgets/icon_picker.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/desire_particle_model.dart';
import 'package:my_life/pages/particles_desire_page.dart';

enum _variantsDesirePage {
  add,
  edit
}

class DesirePage extends StatelessWidget{

  final Desire desire;
  final String pageTitle;
  final _variantsDesirePage selectedPage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DesirePage.add({Key key}) :
        desire = Desire(), pageTitle = 'AddDesirePage',
        selectedPage = _variantsDesirePage.add, super(key: key);

  DesirePage.edit({Key key, @required this.desire}) :
        pageTitle = 'EditDesirePage',
        selectedPage = _variantsDesirePage.edit, super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<DesirePageCubit>(context).addDesire(desire);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: BlocBuilder<DesirePageCubit, DesirePageState>(
        builder: (BuildContext context, DesirePageState state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                        child: IconPicker(model: desire)
                    ),
                    Expanded(
                      flex: 4,
                      child: ListTile(
                        title: SimpleAbstractFormField(model: desire, property: 'title'),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: DateTimePicker(model: desire, title: 'Select Date',),
                ),
                ListTile(
                  title: SimpleAbstractFormField(model: desire, property: 'description', maxLines: 5, validate: false),
                ),
                Column(
                  children: <Widget>[
                    for (DesireParticleModel entry in desire.particleModels) Column(
                      children: [
                        Divider(),
                        entry.build(context, desire)
                      ],
                    ),
                  ],
                ),
                ListTile(
                  title: ElevatedButton(
                      style: ElevatedButton.styleFrom(onPrimary: Colors.brown),
                      child: Text('+'),
                      onPressed: () {
                        BlocProvider.of<DesirePageCubit>(context).desire = desire;
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                            ParticlesDesirePage()
                        ));
                      }
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Row(
          children: <Widget>[
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
        children: <Widget>[
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
    final ButtonStyle deleteButtonStyle = ButtonStyle(foregroundColor: MaterialStateProperty.resolveWith((_) => Colors.redAccent));
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Spacer(),
          TextButton(
            child: Text('Delete'),
            style: deleteButtonStyle,
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
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);
    await cubit.add(desire);
    Navigator.pop(context);
  }

  Future<void> _updateDesire(BuildContext context) async {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);
    await cubit.update(desire);
    Navigator.pop(context);
  }

  Future<void> _deleteDesire(BuildContext context) async {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);
    await cubit.delete(desire);
    Navigator.pop(context);
    Navigator.pop(context);
  }

}