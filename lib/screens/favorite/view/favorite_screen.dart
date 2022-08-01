import 'package:cat_api_test_app/model/model.dart';
import 'package:cat_api_test_app/repository/repository.dart';
import 'package:cat_api_test_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:cat_api_test_app/screens/widgets/cat_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/cached_image.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is FavotiteInitialState) {
        BlocProvider.of<FavoriteBloc>(context).add(FetchFavorite());
        return const Center(child: CircularProgressIndicator());
      } else if (state is FavoriteError) {
        return Center(child: Text(state.error));
      } else if (state is FavoriteSucces) {
        return StreamBuilder(
            stream: FavoriteRepository().fetchItems(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Favorite> list = snapshot.data as List<Favorite>;
              if (list.isEmpty) {
                return const Center(
                  child: Text('You have not any favorites yet'),
                );
              }
              return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 500 ? 4 : 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                          return CatImageScreen(
                            imgUrl: list[index].url,
                            id: list[index].id,
                          );
                        }));
                      },
                      child: Hero(
                        tag: 'dash${list[index].id}',
                        flightShuttleBuilder: (
                          BuildContext flightContext,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext,
                        ) {
                          return SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.all(30),
                              child: Image.network(list[index].url),
                            ),
                          );
                        },
                        child: Stack(children: [
                          CachedImage(imageUrl: list.elementAt(index).url),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: IconButton(
                              onPressed: () async {
                                BlocProvider.of<FavoriteBloc>(context).add(
                                  DislikeEvent(id: list[index].id),
                                );
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                  });
            });
      } else {
        return const Center(child: Text('Unknown error'));
      }
    });
  }
}
