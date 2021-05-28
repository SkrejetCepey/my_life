import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/custom_widgets/date_time_picker.dart';
import 'package:my_life/custom_widgets/icon_picker.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/networking/connection.dart';

enum _variantsGoalPage { add, edit }

class GoalsPage extends StatelessWidget {

  final Desire goal;
  final String pageTitle;
  final _variantsGoalPage selectedPage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GoalsPage.add({Key key})
      : goal = Desire(),
        pageTitle = 'AddGoalPage',
        selectedPage = _variantsGoalPage.add,
        super(key: key);

  GoalsPage.edit({Key key, @required this.goal})
      : pageTitle = 'EditGoalPage',
        selectedPage = _variantsGoalPage.edit,
        super(key: key);

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
            Row(
              children: <Widget>[
                Expanded(child: IconPicker(model: goal)),
                Expanded(
                  flex: 4,
                  child: ListTile(
                    title: SimpleAbstractFormField(
                        model: goal, property: 'title'),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: DateTimePicker(
                  model: goal,
                  title: 'Выбрать дату'),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: DateTimePicker(
                  model: goal,
                  variant: Variants.time,
                  title: 'Выбрать время'),
            ),
            CheckboxListTile(title: Text("Включить напоминание:"), value: false),
            // ListTile(
            //   title: SimpleAbstractFormField(
            //       model: goal, property: 'title'),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Builder(
            builder: (BuildContext context) {
              if (selectedPage == _variantsGoalPage.add) {
                return _addUniqueBottomStaff(context);
              } else if (selectedPage == _variantsGoalPage.edit) {
                return _editUniqueBottomStaff(context);
              } else {
                return Text('Something goes wrong :C');
              }
            },
          )
        ],
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
                _addGoal(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _editUniqueBottomStaff(BuildContext context) {
    final ButtonStyle deleteButtonStyle = ButtonStyle(
        foregroundColor:
        MaterialStateProperty.resolveWith((_) => Colors.redAccent));
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Spacer(),
          TextButton(
            child: Text('Delete'),
            style: deleteButtonStyle,
            onPressed: () async {
              await NotificationDialog.showNotificationDialog(
                  context,
                  'Are you sure about deleting ${goal.title} ?',
                  _deleteGoal);
            },
          ),
          Spacer(),
          TextButton(
            child: Text('Update'),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _updateGoal(context);
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> _updateGoal(BuildContext context) async {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);
    if (BlocProvider.of<UserCubit>(context).user.role == "Guest")
      await cubit.updateGoal(goal);
    else {
      Connection.updateGoal(BlocProvider.of<UserCubit>(context).user, goal)
          .then((value) async => await cubit.updateGoal(goal), onError: (e) => throw e);
    }

    Navigator.pop(context);
  }

  Future<void> _deleteGoal(BuildContext context) async {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);
    Connection.deleteGoal(BlocProvider.of<UserCubit>(context).user, goal.id)
        .then((value) async {
      await cubit.deleteGoal(goal);
      Navigator.pop(context);
      Navigator.pop(context);
    }, onError: (e) => throw e);

  }

  Future<void> _addGoal(BuildContext context) async {

    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);

    await cubit.refresh();

    if (BlocProvider.of<UserCubit>(context).user.role == "Guest")
      await cubit.add(goal);
    else
      await cubit.add(await Connection.addGoal(BlocProvider.of<UserCubit>(context).user, goal));

    Navigator.pop(context);
  }
}

