import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/infrastructure/repository/coupon_repository.dart';

import '../../../infrastructure/repository/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
 NewsBloc(
      {required NewsRepository newsRepository,
      })
      : _newsRepository = newsRepository,
        super(NewsInitialState()) {
    on<GetListNews>((event, emit) async {
      emit(NewsLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        var coupons = await _newsRepository.fetchNews();
        emit(NewsUpdateSuccess(coupons));
      } catch (e) {
        emit(NewsLoadFailed());
      }
    });
  }

  final NewsRepository _newsRepository;
 
 

  
  
  }
  
 

