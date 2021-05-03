import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/models/desire/desire.dart';

class DateTimePicker extends StatelessWidget {

  final String title;
  final Desire model;
  final bool mode;

  DateTimePicker({this.title = 'Pick DateTime!', @required this.model, this.mode = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(onPrimary: Colors.brown),
      child: BlocBuilder<DesiresListCubit, DesiresListState>(
        builder: (BuildContext context, DesiresListState state) {
          if (model.dateTime != null)
            return Text(model.dateTime.toString());
          else
            return Text(title);
        },
      ),
      onPressed: () async {

        if (mode == false) {
          return null;
        }

        DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025)
        );

        if (pickedDate != null) {

          model.dateTime = pickedDate;
          BlocProvider.of<DesiresListCubit>(context).refresh();

          if (model.isInBox)
            await BlocProvider.of<DesiresListCubit>(context).update(model);
        }

      },
    );
  }
}