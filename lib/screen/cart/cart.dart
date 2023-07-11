import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/screen/auth/auth.dart';
import 'package:nike_store/screen/cart/bloc/cart_bloc.dart';
import 'package:nike_store/screen/home/home.dart';
import 'package:nike_store/widgets/empty_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/utility.dart';
import 'cart_show_items.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc? cartBloc;
  final RefreshController _refresher = RefreshController();
  StreamSubscription? subScriptionRefreshedState;

  @override
  void initState() {
    AuthRepository.authChangeNotifier.addListener(authListener);
    super.initState();
  }

  void authListener() {
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier.removeListener(authListener);
    cartBloc?.close();
    subScriptionRefreshedState?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("سبد خرید"),
        ),
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
            cartBloc = bloc;
            bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
            subScriptionRefreshedState = bloc.stream.listen((state) {
              if (_refresher.isRefresh) {
                if (state is CartSuccess) {
                  _refresher.refreshCompleted();
                } else if (state is CartError) {
                  _refresher.refreshFailed();
                }
              }
            });
            return bloc;
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartSuccess) {
                return SmartRefresher(
                  onRefresh: () {
                    cartBloc?.add(CartStarted(
                        AuthRepository.authChangeNotifier.value,
                        isRefreshed: true));
                  },
                  header: const ClassicHeader(
                    completeText: "با موفقیت انجام شد",
                    idleText: "برای بروزرسانی به پایین بکشید",
                    failedText: "با مشکل مواجه شد",
                    refreshingText: "در حال بروزرسانی",
                    releaseText: "رها کنید",
                  ),
                  controller: _refresher,
                  child: ListView.builder(
                    physics: defaultPhysics,
                    itemCount: state.cartResponse.cartItems.length,
                    itemBuilder: (context, index) {
                      final data = state.cartResponse.cartItems[index];
                      return CartShowItems(
                        data: data,
                        onDeleteButton: () {
                          cartBloc!.add(
                              CartOnClickedDeleteButton(data.cart_item_id));
                        },
                      );
                    },
                  ),
                );
              } else if (state is CartError) {
                return Center(child: Text(state.appException.messageError));
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.appException.messageError)));
              } else if (state is CartAuthRequired) {
                return EmptuState(
                  message: " وارد حساب کاربری خود شوید",
                  image: SvgPicture.asset("assets/img/auth_required.svg",
                      width: 140),
                  callToBack: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AuthScreen()));
                    },
                    child: const Text("ورود به حساب کاربری"),
                  ),
                );
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.appException.messageError)));
              } else if (state is CartEmptyState) {
                return EmptuState(
                    message: "هیچ محصولی یافت نشد",
                    image: SvgPicture.asset(
                      "assets/img/empty_cart.svg",
                      width: 220,
                    ),
                    callToBack: ElevatedButton(
                      child: const Text("ورود به فروشگاه"),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      ),
                    ));
              } else {
                throw Exception("State not valid");
              }
            },
          ),
        )

        //   ValueListenableBuilder<AuthInfo?>(
        //     valueListenable: AuthRepository.authChangeNotifier,
        //     builder: (context, authState, child) {
        //       final bool isAutenticated =
        //           authState != null && authState.accessToken.isNotEmpty;
        //       return SizedBox(
        //         width: MediaQuery.of(context).size.width,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text(isAutenticated
        //                 ? "خوش آمدید"
        //                 : "لطفا وارد حساب کاربری خود شوید"),
        //             isAutenticated
        //                 ? ElevatedButton(
        //                     onPressed: () {
        //                       authRepository.signOut();
        //                     },
        //                     child: const Text("خروج از حساب"))
        //                 : ElevatedButton(
        //                     onPressed: () {
        //                       Navigator.of(context, rootNavigator: true)
        //                           .push(MaterialPageRoute(
        //                         builder: (context) => AuthScreen(),
        //                       ));
        //                     },
        //                     child: const Text("ورود حساب کاربری")),
        //             ElevatedButton(
        //                 onPressed: () {
        //                   authRepository.refreshToken();
        //                 },
        //                 child: Text("Refresh Tokem"))
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        );
  }
}
