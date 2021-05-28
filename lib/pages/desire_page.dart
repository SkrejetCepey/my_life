import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/cubits/local_desire_page/local_desire_page_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/custom_widgets/date_time_picker.dart';
import 'package:my_life/custom_widgets/icon_picker.dart';
import 'package:my_life/custom_widgets/rounded_days_week_checkbox.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/desire_particle_model.dart';
import 'package:my_life/pages/particles_desire_page.dart';

enum _variantsDesirePage { add, edit }

class DesirePage extends StatelessWidget {
  final Desire desire;
  final String pageTitle;
  final _variantsDesirePage selectedPage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DesirePage.add({Key key})
      : desire = Desire(),
        pageTitle = 'AddDesirePage',
        selectedPage = _variantsDesirePage.add,
        super(key: key);

  DesirePage.edit({Key key, @required this.desire})
      : pageTitle = 'EditDesirePage',
        selectedPage = _variantsDesirePage.edit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DesirePageCubit>(context).addDesire(desire);

    return BlocProvider<LocalDesirePageCubit>(
      create: (_) => LocalDesirePageCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            children: [
              Row(
                children: <Widget>[
                  Expanded(child: IconPicker(model: desire)),
                  Expanded(
                    flex: 4,
                    child: ListTile(
                      title: SimpleAbstractFormField(
                          model: desire, property: 'title'),
                    ),
                  ),
                ],
              ),
              BlocBuilder<LocalDesirePageCubit, LocalDesirePageState>(
                builder: (context, state) {
                  var cubit = BlocProvider.of<LocalDesirePageCubit>(context);
                  return Column(
                    children: [
                      CheckboxListTile(
                          title: Text("Цель по задаче:"),
                          // onChanged: cubit.changeGoalByTask
                          value: cubit.goalByTask),
                      CheckboxListTile(
                          title: Text("Повторять каждый день:"),
                          // onChanged: cubit.changeRetryEveryDay
                          value: cubit.retryEveryDay),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 75.0, vertical: 10.0),
                        child: Row(
                          children: [
                            RoundedDaysWeekCheckbox(
                                state: false, charWeek: "П"),
                            Spacer(),
                            RoundedDaysWeekCheckbox(
                                state: false, charWeek: "В"),
                            Spacer(),
                            RoundedDaysWeekCheckbox(
                                state: false, charWeek: "С"),
                            Spacer(),
                            RoundedDaysWeekCheckbox(
                                state: false, charWeek: "Ч"),
                            Spacer(),
                            RoundedDaysWeekCheckbox(
                                state: false, charWeek: "П"),
                            Spacer(),
                            RoundedDaysWeekCheckbox(
                                state: false, charWeek: "С"),
                            Spacer(),
                            RoundedDaysWeekCheckbox(
                                state: false, charWeek: "В"),
                          ],
                        ),
                      ),
                      CheckboxListTile(
                          title: Text("Один раз в любое время:"),
                          // onChanged: cubit.changeOneTimeAnyTime
                          value: cubit.oneTimeAnyTime),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 45.0, vertical: 10.0),
                        child: Row(
                          children: [
                            RoundedDaysWeekCheckbox(
                                state: false,
                                charWeek: "Утро",
                                width: 65.0,
                                height: 35.0,
                                circularRadius: 10.0),
                            Spacer(),
                            RoundedDaysWeekCheckbox(
                                state: false,
                                charWeek: "День",
                                width: 65.0,
                                height: 35.0,
                                circularRadius: 10.0),
                            Spacer(),
                            RoundedDaysWeekCheckbox(
                                state: false,
                                charWeek: "Вечер",
                                width: 65.0,
                                height: 35.0,
                                circularRadius: 10.0),
                          ],
                        ),
                      ),
                      (!cubit.dateEndOrCount)
                          ? CheckboxListTile(
                              title: Text("Дата окончания или количество:"),
                              value: cubit.dateEndOrCount,
                              onChanged: cubit.changeDateEndOrCount)
                          : Column(
                              children: [
                                CheckboxListTile(
                                    title:
                                        Text("Дата окончания или количество:"),
                                    value: cubit.dateEndOrCount,
                                    onChanged: cubit.changeDateEndOrCount),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 45.0, vertical: 10.0),
                                  child: Row(
                                    children: [
                                      RoundedDaysWeekCheckbox(
                                          state: cubit.chooseDate,
                                          charWeek: "Дата",
                                          width: 80.0,
                                          height: 35.0,
                                          circularRadius: 10.0,
                                          callback: cubit.changeChooseDate),
                                      Spacer(),
                                      RoundedDaysWeekCheckbox(
                                          state: cubit.chooseCount,
                                          charWeek: "Количество",
                                          width: 100.0,
                                          height: 35.0,
                                          circularRadius: 10.0,),
                                          // callback: cubit.changeChooseCount),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      Builder(
                        builder: (BuildContext context) {
                          if (cubit.dateEndOrCount) {
                            if (cubit.chooseDate) {
                              return ListTile(
                                title:
                                    (selectedPage == _variantsDesirePage.edit)
                                        ? DateTimePicker(
                                            model: desire,
                                            title: 'Выбрать дату',
                                            mode: false)
                                        : DateTimePicker(
                                            model: desire,
                                            title: 'Выбрать дату'),
                              );
                            } else {
                              return Container(
                                  margin: EdgeInsets.all(15.0),
                                  height: 30.0,
                                  child: SimpleAbstractFormField());
                            }
                          } else {
                            return Container();
                          }
                        },
                      ),
                      (!cubit.canNotification) ? CheckboxListTile(
                          title: Text("Включить напоминание:"), value: cubit.canNotification)
                          : Column(
                        children: [
                          CheckboxListTile(
                              title: Text("Включить напоминание:"), value: cubit.canNotification, onChanged: cubit.changeCanNotification),
                          ListTile(
                            title: DateTimePicker(
                                model: desire, title: 'Выбрать время', mode: false),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<DesirePageCubit, DesirePageState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Column(
                        children: <Widget>[
                          for (DesireParticleModel entry
                              in desire.particleModels.toSet())
                            Column(
                              children: [
                                Divider(),
                                entry.buildUnique(context, desire)
                              ],
                            ),
                        ],
                      ),
                      ListTile(
                        title: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onPrimary: Colors.brown),
                            child: Text('+'),
                            onPressed: () {
                              if (selectedPage == _variantsDesirePage.edit) {
                                return null;
                              }
                              BlocProvider.of<DesirePageCubit>(context).desire =
                                  desire;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ParticlesDesirePage()));
                            }),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
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
              if (desire.dateTime == null) {
                Future.microtask(() => ScaffoldMessenger.of(context)
                    .showSnackBar(
                        SnackBar(content: Text('The date cannot be null!'))));
                return null;
              }
              if (_formKey.currentState.validate() && desire.dateTime != null) {
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
                  'Are you sure about deleting ${desire.title} ?',
                  _deleteDesire);
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

    desire.particleModels = desire.particleModels.map((e) {
      e.dateTime = this.desire.dateTime;
      return e;
    }).toList();

    await cubit.add(desire);
    Navigator.pop(context);
  }

  Future<void> _updateDesire(BuildContext context) async {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);

    // var er = desire.particleModels.toSet().toList();
    //
    // for (int i = 0; i < er.length; i++) {
    //   for (int j = 0; j < 3; j++) {
    //     desire.particleModels.map((e) {
    //       if (er[i].id == e.id) {
    //         if (er[i] == e) {
    //           return e;
    //         }
    //       } else {
    //         return er[i].clone(e.dateTime, e.state);
    //       }
    //     });
    //   }
    // }

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
