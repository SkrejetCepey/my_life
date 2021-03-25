import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/db/hive_db.dart';
import 'package:my_life/models/icon_data_structure/icon_data_structure.dart';
import 'package:my_life/observer/global_observer.dart';
import 'package:my_life/pages/auth_page.dart';
import 'package:my_life/pages/main_page.dart';
import 'package:my_life/pages/signup_page.dart';
import 'desire_particles/particle_checkbox/particle_checkbox.dart';
import 'models/desire/desire.dart';


void main() async {
  Bloc.observer = GlobalObserver();

  await Hive.initFlutter();
  HiveDB.db.database;
  initializeDateFormatting();
  Hive.registerAdapter(DesireAdapter());
  Hive.registerAdapter(ParticleCheckboxAdapter());
  Hive.registerAdapter(IconDataStructureAdapter());
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DesirePageCubit>(
          create: (_) => DesirePageCubit(),
        ),
        BlocProvider<DesiresListCubit>(
          create: (_) => DesiresListCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => Colors.limeAccent[400]),
            )
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.lime,
          ),
          primaryColor: Colors.limeAccent[400],
        ),
        routes: {
          '/sign_up': (BuildContext context) => SignUpPage(),
          '/main': (BuildContext context) => MainPage()
        },
        home: Scaffold(
          body: AuthPage()
        ),
      ),
    );
  }

}