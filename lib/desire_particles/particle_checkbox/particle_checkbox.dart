import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/particle_checkbox/particle_checkbox_cubit.dart';
import 'package:my_life/custom_widgets/simple_abstract_form_field.dart';
import 'package:my_life/handlers/notification_dialog.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/desire_particle_model.dart';

part 'particle_checkbox.g.dart';

@HiveType(typeId: 1)
class ParticleCheckbox extends HiveObject implements DesireParticleModel, AbstractModel {

  @HiveField(0)
  String title;
  @HiveField(1)
  bool state;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ParticleCheckbox({this.title, this.state}) {
    if (state == null)
      state = false;
  }

  @override
  Map<String, String> get properties => {
    'title': title
  };

  @override
  set properties(Map<String, dynamic> s) {
    if (s['title'] != null)
      title = s['title'];
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
            SizedBox(
              height: 10.0,
            ),
            ListTile(
              title: SimpleAbstractFormField(model: this, property: 'title'),
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
  Scaffold editPage(BuildContext context, Desire desire) {

    final TextEditingController _titleTextEditingController = TextEditingController();
    _titleTextEditingController.text = title;

    Future<void> _deleteDesireParticle(BuildContext context) async {
      DesirePageCubit cubit = BlocProvider.of<DesirePageCubit>(context);
      if (cubit.desire.particleModels.length == 1) {
        cubit.desire.isExpanded = false;
      }
      cubit.delete(this);
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
  Widget build(BuildContext context, Desire desire) {
    return BlocProvider<ParticleCheckboxCubit>(
      create: (_) => ParticleCheckboxCubit(this),
      child: BlocBuilder<ParticleCheckboxCubit, ParticleCheckboxState>(
        builder: (BuildContext context, ParticleCheckboxState state) {
          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                  editPage(context, desire)));
            },
            title: Row(
              children: [
                RoundedCheckbox(state: this.state, desire: desire),
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

class RoundedCheckbox extends StatelessWidget {

  final bool state;
  final Desire desire;

  RoundedCheckbox({this.state, this.desire});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: state ? Icon(Icons.check_circle_outline) : Icon(FontAwesomeIcons.circle),
        onPressed: () {
          BlocProvider.of<ParticleCheckboxCubit>(context).switchParticleCheckBoxState();
          BlocProvider.of<DesiresListCubit>(context).update(desire);
        },
      )
    );
  }
}