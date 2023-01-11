import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/coupon/coupon_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/coupon/coupon_state.dart';
import 'package:tren_boong_concept/features/news/shimmer_news.dart';
import '../../domain/bloc/coupon/coupon_event.dart';
import '../../domain/bloc/news/news_bloc.dart';
import '../../domain/bloc/news/news_state.dart';
import '../../infrastructure/repository/coupon_repository.dart';
import '../../utility/save_data.dart';
import 'news_list.dart';

class NewsHolder extends StatefulWidget {
  const NewsHolder({super.key});

  @override
  State<NewsHolder> createState() => NewsHolderState();
}

class NewsHolderState extends State<NewsHolder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
        builder: (BuildContext context, NewsState state) {
      if (state is NewsUpdateSuccess) {
        return NewsList(news: state.news);
      }
      return ShimmerNews();
    });
  }
}
