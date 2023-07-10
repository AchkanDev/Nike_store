part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartResponse cartResponse;

  const CartSuccess(this.cartResponse);

  @override
  // TODO: implement props
  List<Object> get props => [cartResponse];
}

class CartError extends CartState {
  final AppException appException;

  const CartError(this.appException);
  List<Object> get props => [appException];
}

class CartAuthRequired extends CartState {}
