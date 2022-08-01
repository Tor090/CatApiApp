import 'package:cat_api_test_app/screens/favorite/bloc/favorite_bloc.dart';
import 'package:cat_api_test_app/screens/widgets/cached_image.dart';
import 'package:cat_api_test_app/screens/widgets/cat_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatImageBloc, CatImageState>(
      builder: (context, state) {
        if (state is InitialState) {
          BlocProvider.of<CatImageBloc>(context).add(FetchCatImage());
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is LoadedState) {
          return LazyLoadScrollView(
            onEndOfPage: () =>
                BlocProvider.of<CatImageBloc>(context)..add(FetchNewCatImage()),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 500 ? 4 : 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: state.catImageList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return CatImageScreen(
                        imgUrl: state.catImageList[index].url,
                        id: state.catImageList[index].id,
                      );
                    }));
                  },
                  child: Hero(
                    tag: 'dash${state.catImageList[index].id}',
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
                          child: Image.network(state.catImageList[index].url),
                        ),
                      );
                    },
                    child: Stack(children: [
                      CachedImage(imageUrl: state.catImageList[index].url),
                      Positioned(
                          right: 5,
                          bottom: 5,
                          child: IconButton(
                            onPressed: () async {
                              BlocProvider.of<FavoriteBloc>(context).add(
                                  AddFavoriteEvent(
                                      id: state.catImageList[index].id,
                                      url: state.catImageList[index].url));
                              BlocProvider.of<CatImageBloc>(context)
                                  .add(UpdateAfterLike(index: index));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Image moved to favorite')));
                              //state.catImageList.removeAt(index);
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.grey,
                            ),
                          ))
                    ]),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
