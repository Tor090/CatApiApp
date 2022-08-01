import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_api_test_app/screens/home/bloc/fact_bloc/cat_facts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/api_service.dart';

class CatImageScreen extends StatelessWidget {
  final String imgUrl;
  final String id;

  const CatImageScreen({Key? key, required this.imgUrl, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: imgUrl,
              ),
              const Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Facts(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Facts extends StatelessWidget {
  const Facts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CatFactsBloc(apiService: ApiService())..add(FactsLoad()),
      child: BlocBuilder<CatFactsBloc, CatFactsState>(
        builder: (context, state) {
          if (state is CatFactsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatFactsLoaded) {
            List<String> _facts = state.facts;
            return Column(
              children: _facts
                  .map(
                    (e) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('«$e»',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ),
                  )
                  .toList(),
            );
          } else if (state is CatFactsError) {
            return Column(children: [
              const SizedBox(
                height: 100,
              ),
              Text(state.error),
            ]);
          } else {
            return const Center(child: Text('Unknown error'));
          }
        },
      ),
    );
  }
}
