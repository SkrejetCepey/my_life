import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/models/desire/desire.dart';

enum Variants { date, time, datetime }

class DateTimePicker extends StatelessWidget {

  final String title;
  final Desire model;
  final bool mode;
  final Variants variant;

  DateTimePicker({this.title = 'Pick DateTime!', @required this.model, this.mode = true, this.variant = Variants.date});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(onPrimary: Colors.brown),
      child: BlocBuilder<DesiresListCubit, DesiresListState>(
        builder: (BuildContext context, DesiresListState state) {
          if (variant == Variants.date && model.dateTime != null)
            return Text(model.dateTime.toString().split(" ").first);
          else if (variant == Variants.date)
            return Text("Выбрать дату");
          else if (variant == Variants.time && model.dateTime != null && model.dateTime.hour != 0)
            return Text("${model.dateTime.hour}:${model.dateTime.minute}:${model.dateTime.second}");
          else if (variant == Variants.time)
            return Text("Выбрать время");
          else
            return Text(title);
        },
      ),
      onPressed: () async {

        if (mode == false) {
          return null;
        }

        DateTime pickedDate;
        TimeOfDay pickedTime;

        if (variant == Variants.date || variant == Variants.datetime) {
          pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2025)
          );
        }

        if (variant == Variants.time || variant == Variants.datetime) {
          pickedTime = await showTimePicker(
              context: context,
              initialTime: (model.dateTime != null && model.dateTime.hour != 0) ?
              TimeOfDay(hour: model.dateTime.hour, minute: model.dateTime.minute)
                  : TimeOfDay.now());
        }

        if (pickedTime != null) {

          if (model.dateTime != null) {
            print(model.dateTime);
            model.dateTime = model.dateTime.add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute));
          }
          else
            pickedDate = pickedDate.add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute));

        }

        if (pickedDate != null || model.dateTime != null) {

          model.dateTime = pickedDate ?? model.dateTime;
          BlocProvider.of<DesiresListCubit>(context).refresh();

          if (model.isInBox)
            await BlocProvider.of<DesiresListCubit>(context).update(model);
        }

      },
    );
  }
}