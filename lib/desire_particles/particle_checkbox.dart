import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:my_life/cubits/particle_checkbox/particle_checkbox_cubit.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/desire_particle_model.dart';

part 'particle_checkbox.g.dart';

@HiveType(typeId: 1)
class ParticleCheckbox extends HiveObject implements DesireParticleModel, AbstractModel {

  @HiveField(0)
  String title;

  final Desire desire;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ParticleCheckbox({this.desire});

  @override
  Widget skinView(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
            addPage(context)));
      },
      title: Text('Checkbox'),
    );
  }

  @override
  Scaffold addPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ParticleCheckBoxCreating'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  fillColor: Colors.white60,
                  hintText: 'title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.blue)
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
                ),
                validator: (String s) => s.isEmpty ? "title can't be empty!" : null,
                onSaved: (String s) {
                  title = s;
                },
              ),
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
            Spacer(),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  // desirePageCubit.add(this);
                  desire.particleModels.add(this);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParticleCheckboxCubit(),
      child: BlocBuilder<ParticleCheckboxCubit, bool>(
        builder: (BuildContext context, bool state) {
          return ListTile(
            title: Row(
              children: [
                Checkbox(
                  value: state,
                  onChanged: (_) => BlocProvider.of<ParticleCheckboxCubit>(context).switchParticleCheckBoxState(),
                ),
                Text(title),
              ],
            ),
          );
        },
      ),
    );
  }

}
