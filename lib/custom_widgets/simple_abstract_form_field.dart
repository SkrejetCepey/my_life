import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_life/desire_particles/particle_checkbox/particle_checkbox.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/user.dart';

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
        if (model is User)
          return (model as User).add(property, s);
        else if (model is Desire) {
          if (property == 'title')
            (model as Desire).title = s;
          else if (property == 'description')
            (model as Desire).description = s;
        } else if (model is ParticleCheckbox) {
          (model as ParticleCheckbox).title = s;
        }
      },
    );
  }
}