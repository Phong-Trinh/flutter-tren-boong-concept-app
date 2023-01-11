import 'package:equatable/equatable.dart';
import '../../entity/coupon_entity.dart';
import '../../entity/newfeeds_entity.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class  NewsInitialState extends NewsState {}

class  NewsLoadingState extends NewsState {}

class  NewsUpdateSuccess extends NewsState {
  final List<NewsEntity> news;
  const  NewsUpdateSuccess(this.news);
}

class  NewsLoadFailed extends NewsState {}
