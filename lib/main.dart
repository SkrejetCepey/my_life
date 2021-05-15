import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_life/cubits/appbar_builder/appbar_builder_cubit.dart';
import 'package:my_life/cubits/desire_page/desire_page_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/table_calendar/table_calendar_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/models/icon_data_structure/icon_data_structure.dart';
import 'package:my_life/models/user/user.dart';
import 'package:my_life/observer/global_observer.dart';
import 'package:my_life/pages/auth_page.dart';
import 'package:my_life/pages/main_page.dart';
import 'package:my_life/pages/signup_page.dart';
import 'desire_particles/particle_checkbox/particle_checkbox.dart';
import 'models/desire/desire.dart';

void main() async {
  Bloc.observer = GlobalObserver();

  await Hive.initFlutter();

  await initializeDateFormatting();

  Hive.registerAdapter(DesireAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ParticleCheckboxAdapter());
  Hive.registerAdapter(IconDataStructureAdapter());

  await UserHiveRepository.db.database;

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
          create: (context) => DesiresListCubit(BlocProvider.of<DesirePageCubit>(context)),
        ),
        BlocProvider<UserCubit>(
          create: (_) => UserCubit(),
        ),
        BlocProvider<TableCalendarCubit>(
          create: (_) => TableCalendarCubit(),
        ),
        BlocProvider<AppBarBuilderCubit>(
          create: (_) => AppBarBuilderCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => const Color(0xffd5f111)),
            )
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: const Color(0xffd5f111),
          ),
          primaryColor: const Color(0xffd5f111),
        ),
        routes: {
          '/sign_up': (BuildContext context) => SignUpPage(),
          '/main': (BuildContext context) => MainPage(),
          '/home': (BuildContext context) => HomePageFactory(),
        },
        home: HomePageFactory(),
      ),
    );
  }

}

class HomePageFactory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, UserState state) {
        return Builder(
          builder: (BuildContext context) {
            return AuthPage();
            // if (state is UserInitEmpty)
            //   return AuthPage();
            // else if (state is UserInit) {
            //   BlocProvider.of<DesiresListCubit>(context).updateUser(BlocProvider.of<UserCubit>(context).user);
            //   return MainPage();
            // }
            // else {
            //   return Center(
            //       child: CircularProgressIndicator()
            //   );
            // }
          },
        );
      },
    );
  }
}