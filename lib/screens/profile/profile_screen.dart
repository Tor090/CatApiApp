import 'package:cat_api_test_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          CircleAvatar(
            radius: 48,
            backgroundImage:
                user.photo != null ? NetworkImage(user.photo!) : null,
            child: user.photo == null
                ? const Icon(
                    Icons.person,
                    size: 48,
                  )
                : null,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(user.name ?? ''),
          const SizedBox(
            height: 20,
          ),
          Text(user.email ?? ''),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              //primary: Colors.orangeAccent,
            ),
            onPressed: () => context.read<AuthBloc>().add(
                  AppLogoutRequested(),
                ),
            child: const Text('LOG OUT'),
          ),
        ],
      ),
    );
  }
}
