import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/cubits/particle_checkbox/particle_checkbox_cubit.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/desire_particle_model.dart';

part 'particle_checkbox.g.dart';

@HiveType(typeId: 1)
class ParticleCheckbox extends HiveObject implements DesireParticleModel, AbstractModel {

  @HiveField(0)
  String title;
  @HiveField(1)
  bool serialisedState;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ParticleCheckbox({this.title, this.serialisedState}) {
    if (serialisedState == null)
      serialisedState = false;
  }

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
              title: SimpleAbstractFormField(model: this, iconData: Icons.title, property: 'title'),
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
                  BlocProvider.of<DesirePageCubit>(context).add(this);
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
  Scaffold editPage(BuildContext context) {

    final TextEditingController _titleTextEditingController = TextEditingController();
    _titleTextEditingController.text = title;

    Future<void> _deleteDesireParticle(BuildContext context) async {
      BlocProvider.of<DesirePageCubit>(context).delete(this);
      Navigator.pop(context);
    }

    final ButtonStyle deleteButtonStyle = ButtonStyle(foregroundColor: MaterialStateProperty.resolveWith((_) => Colors.redAccent));

    return Scaffold(
      appBar: AppBar(
        title: Text('ParticleCheckBoxEditing'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: TextFormField(
                controller: _titleTextEditingController,
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
              style: deleteButtonStyle,
              child: Text('Delete'),
              onPressed: () async {
                await NotificationDialog.showNotificationDialog(context,
                    'Are you sure about deleting ${this.title} ?',
                    _deleteDesireParticle);
                // desirePageCubit.delete(this);
                Navigator.pop(context);
              },
            ),
            Spacer(),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  BlocProvider.of<DesirePageCubit>(context).update(this);
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
    return BlocProvider<ParticleCheckboxCubit>(
      create: (_) => ParticleCheckboxCubit(serialisedState),
      child: BlocBuilder<ParticleCheckboxCubit, bool>(
        builder: (BuildContext context, bool state) {
          serialisedState = state;
          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                  editPage(context)));
            },
            title: Row(
              children: [
                Checkbox(
                  value: state,
                  onChanged: (_) => BlocProvider.of<ParticleCheckboxCubit>(context).switchParticleCheckBoxState(),
                ),
                Flexible(
                    child: Text(title)
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
