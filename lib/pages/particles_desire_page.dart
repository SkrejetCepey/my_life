import 'package:flutter/material.dart';
import 'package:my_life/desire_particles/particle_checkbox.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/desire_particle_model.dart';

class ParticlesDesirePage extends StatelessWidget {

  final Desire desire;
  final List<DesireParticleModel> _generationList;

  ParticlesDesirePage({@required this.desire}) :
    _generationList = [
      ParticleCheckbox(desire: desire),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ParticlesDesirePage'),
      ),
      body: ListView.builder(
        itemCount: _generationList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child: Card(
              child: _generationList[index].skinView(context)
            ),
          );
        },
      ),
    );
  }
}

