import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:my_life/cubits/icon_picker/icon_picker_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/models/desire/desire.dart';

class IconPicker extends StatelessWidget {

  final Desire model;

  IconPicker({@required this.model});

  @override
  Widget build(BuildContext context) {

    _pickIcon(IconPickerCubit cubit) async {
      IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconSize: 50,
        iconPickerShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Выберите иконку:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        closeChild: Text(
          'Закрыть',
          textScaleFactor: 1.25,
        ),
        searchHintText: 'Найти иконку...',
        noResultsText: 'Ничего не найдено по запросу:',
      );


      if (icon != null)
        cubit.addIcon(icon);

      if (BlocProvider.of<DesiresListCubit>(context).user.desiresList.where((element) => element == model).isNotEmpty)
        BlocProvider.of<DesiresListCubit>(context).update(model);
    }

    return BlocProvider<IconPickerCubit>(
      create: (_) => IconPickerCubit(model: model),
      child: BlocBuilder<IconPickerCubit, IconPickerState>(
        builder: (BuildContext context, IconPickerState state) {
          IconPickerCubit cubit = BlocProvider.of<IconPickerCubit>(context);
          return Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            child: IconButton(
              iconSize: 50,
              icon: cubit.model.iconDataStructure == null ?
              Icon(Icons.add_photo_alternate_outlined) :
              Icon(cubit.model.iconDataStructure.iconData),
              onPressed: () {
                _pickIcon(cubit);
              },
            ),
          );
        },
      ),
    );
  }
}