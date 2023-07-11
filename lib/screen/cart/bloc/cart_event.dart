part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;

  const CartStarted(this.authInfo);
}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChanged(this.authInfo);
}

class CartOnClickedDeleteButton extends CartEvent {
  final int cartItemId;

  CartOnClickedDeleteButton(this.cartItemId);
}
