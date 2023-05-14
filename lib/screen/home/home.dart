import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/main.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  final GestureTapCallback themeSwitchToModeDark;
  final GestureTapCallback themeSwitchToModeLight;

  const HomeScreen(
      {super.key,
      required this.themeSwitchToModeDark,
      required this.themeSwitchToModeLight});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final homebloc = HomeBloc(
            bannnerRepository: bannerRepository,
            productRepository: productRepository);
        homebloc.add(HomeStarted());

        return homebloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  itemCount: 5,
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 100),
                  itemBuilder: (context, index) {
                    String a = state.latestProduct[8].image;
                    switch (index) {
                      case 0:
                        return brightness == Brightness.dark
                            ? InkWell(
                                onTap: themeSwitchToModeDark,
                                child: Image.asset(
                                  "assets/img/nike_dark.png",
                                  height: 32,
                                ),
                              )
                            : InkWell(
                                onTap: themeSwitchToModeLight,
                                child: Image.asset(
                                  "assets/img/nike_logo.png",
                                  height: 32,
                                ),
                              );
                      default:
                        return Container(
                          child: Image.network(
                            a,
                            height: 500,
                          ),
                        );
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("خطای نامشخص"),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(HomeRefresh());
                          },
                          child: Text("تلاش دوباره"))
                    ],
                  ),
                );
              } else {
                throw Exception("invalid state");
              }
            },
          ),
        ),
      ),
    );
  }
}
