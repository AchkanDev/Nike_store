import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/screen/auth/auth.dart';
import 'package:nike_store/screen/cart/bloc/cart_bloc.dart';
import 'package:nike_store/widgets/loadingImage.dart';

import 'cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc? cartBloc;
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
            return bloc;
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartSuccess) {
                return CartItem(
                  state: state,
                );
              } else if (state is CartError) {
                return Center(child: Text(state.appException.messageError));
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.appException.messageError)));
              } else if (state is CartAuthRequired) {
                return Center(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AuthScreen()));
                  },
                  child: Text("ورود"),
                ));
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.appException.messageError)));
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
