import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/news/news_event.dart';
import 'package:tren_boong_concept/features/news/shimmer_news.dart';
import '../../domain/bloc/news/news_bloc.dart';
import '../../domain/bloc/news/news_state.dart';
import '../../infrastructure/repository/news_repository.dart';
import 'news_list.dart';

class NewsHolder extends StatefulWidget {
  const NewsHolder({super.key});

  @override
  State<NewsHolder> createState() => NewsHolderState();
}

class NewsHolderState extends State<NewsHolder> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => NewsRepository(),
        child: BlocProvider(
            create: (context) => NewsBloc(
                  newsRepository: context.read<NewsRepository>(),
                )..add(GetListNews()),
            child: BlocBuilder<NewsBloc, NewsState>(
                builder: (BuildContext context, NewsState state) {
              if (state is NewsUpdateSuccess) {
                return NewsList(news: state.news);
              }
              return ShimmerNews();
            })));
  }
}
