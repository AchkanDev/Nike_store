import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

import '../../../common/appExeption.dart';
import '../../../data/auth_info.dart';
import '../../../data/cart_response.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        final authinfo = event.authInfo;
        if (authinfo == null || authinfo.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          await cartState(emit, event.isRefreshed);
        }
      } else if (event is CartAuthInfoChanged) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          await cartState(emit, false);
        }
      } else if (event is CartOnClickedDeleteButton) {
        if (state is CartSuccess) {
          try {
            final successState = (state as CartSuccess);
            final cartItem = successState.cartResponse.cartItems.indexWhere(
                (element) => element.cart_item_id == event.cartItemId);
            successState.cartResponse.cartItems[cartItem].loadingOnDeleting =
                true;

            emit(CartSuccess(successState.cartResponse));
          } catch (e) {
            debugPrint(e.toString());
          }
        }
        await cartRepository.delete(event.cartItemId);
        if (state is CartSuccess) {
          try {
            final successState = (state as CartSuccess);
            successState.cartResponse.cartItems.removeWhere(
                (element) => element.cart_item_id == event.cartItemId);
            if (successState.cartResponse.cartItems.isEmpty) {
              emit(CartEmptyState());
            } else {
              emit(CartSuccess(successState.cartResponse));
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      }
    });
  }
  Future<void> cartState(Emitter<CartState> emit, bool isRefreshed) async {
    try {
      if (!isRefreshed) {
        emit(CartLoading());
      }
      final CartResponse cartResponse = await cartRepository.getAll();
      if (cartResponse.cartItems.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartSuccess(cartResponse));
      }
    } catch (e) {
      emit(CartError(AppException(messageError: e.toString())));
    }
  }
}
