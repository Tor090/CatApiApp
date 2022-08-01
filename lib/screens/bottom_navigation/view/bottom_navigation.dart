import 'package:cat_api_test_app/main.dart';
import 'package:cat_api_test_app/screens/bottom_navigation/bottom_navigation.dart';
import 'package:cat_api_test_app/screens/home/view/home_screen.dart';
import 'package:cat_api_test_app/screens/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/favorite_repository/favorite_repository.dart';
import '../../../service/api_service.dart';
import '../../favorite/favorite.dart';
import '../../home/bloc/image_bloc/cat_image_bloc.dart';
import '../../profile/profile_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CatImageBloc(getIt<ApiService>())),
        BlocProvider(
            create: (context) => TabBloc()..add(const UpdateTab(Tabs.home))),
        BlocProvider(
            create: (context) =>
                FavoriteBloc(favoriteRepository: getIt<FavoriteRepository>())),
      ],
      child: BlocBuilder<TabBloc, Tabs>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: state == Tabs.home
                    ? const Text('Home')
                    : (state == Tabs.favorite
                        ? const Text('favorite')
                        : const Text('Profile')),
                actions: [
                  LogoutButton(visible: state == Tabs.profile ? true : false)
                ],
              ),
              body: state == Tabs.home
                  ? const HomeScreen()
                  : (state == Tabs.favorite
                      ? const FavoriteScreen()
                      : ProfileScreen()),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: Tabs.values.indexOf(state),
                showSelectedLabels: true,
                showUnselectedLabels: false,
                onTap: (selectedtab) => BlocProvider.of<TabBloc>(context)
                    .add(UpdateTab(Tabs.values[selectedtab])),
                items: Tabs.values.map((e) {
                  return BottomNavigationBarItem(
                      icon: Icon(e == Tabs.home
                          ? Icons.home
                          : (e == Tabs.favorite
                              ? Icons.favorite
                              : Icons.person)),
                      label: e == Tabs.home
                          ? 'Home'
                          : (e == Tabs.favorite ? 'favorite' : 'Profile'));
                }).toList(),
              ));
        },
      ),
    );
  }
}
