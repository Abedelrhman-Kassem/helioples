part of 'liked_cubit.dart';

sealed class LikedState extends Equatable {
  const LikedState();

  @override
  List<Object> get props => [];
}

final class LikedInitial extends LikedState {}

final class FetchLikedLoading extends LikedState {}

final class FetchLikedSuccess extends LikedState {
  final LikedModel product;

  const FetchLikedSuccess(this.product);
}

final class FetchLikedFailure extends LikedState {
  final String message;

  const FetchLikedFailure(this.message);
}

final class UnLoggedState extends LikedState {}
