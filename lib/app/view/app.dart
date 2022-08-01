import 'package:cat_api_test_app/repository/repository.dart';
import 'package:cat_api_test_app/screens/bottom_navigation/view/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/login/view/login_page.dart';
import '../app.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.user.isNotEmpty) {
          return BottomNavigation();
        } else if (state.user.isEmpty) {
          return const LoginPage();
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('No internet')),
          );
        }
      },
    ));
  }
}
