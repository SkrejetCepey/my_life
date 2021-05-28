import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/habits/goal.dart';

class SimpleAbstractFormField extends StatelessWidget {

  final AbstractModel model;
  final String property;
  final int maxLines;
  final bool validate;
  final TextEditingController _titleTextEditingController = TextEditingController();

  SimpleAbstractFormField({Key key,
    @required this.model,
    @required this.property,
    this.maxLines = 1,
    this.validate = true}) : super(key: key) {
    if (model is Goal) {
      if (property == 'title')
        _titleTextEditingController.text = (model as Goal).title;
    }
    if (model is Desire)
      if (!(model as Desire).isEmpty()) {
        if (property == 'title')
          _titleTextEditingController.text = (model as Desire).title;
        else if (property == 'description')
          _titleTextEditingController.text = (model as Desire).description;
      }
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild simple abstract $property form=======");
    return TextFormField(
      maxLines: maxLines,
      controller: _titleTextEditingController,
      decoration: InputDecoration(
        fillColor: Colors.white60,
        hintText: property,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
      ),
      validator: validate ? (String s) => s.isEmpty ? "$property can't be empty!" : null : null,
      onSaved: (String s) {
        return model.properties = <String, String>{property: s};
      },
    );
  }
}