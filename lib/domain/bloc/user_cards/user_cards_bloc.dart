import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/infrastructure/repository/card_repository.dart';
import '../../../utility/save_data.dart';
import '../main_card/main_card_bloc.dart';
import 'user_cards_event.dart';
import 'user_cards_state.dart';

class UserCardsBloc extends Bloc<UserCardsEvent, UserCardsState> {
  //pass value to state to reponse to UI

  UserCardsBloc(
      {required CardRepository cardRepository,
      required MainCardBloc mainCardBloc})
      : _cardRepository = cardRepository,
        _mainCardBloc = mainCardBloc,
        super(CardsInitialState()) {
    on<GetCardsEvent>(fetchCardsEvent);
  }

  final CardRepository _cardRepository;
  final MainCardBloc _mainCardBloc;

  Future<void> fetchCardsEvent(
      GetCardsEvent event, Emitter<UserCardsState> state) async {
    emit(CardsLoadingState());
    var cards = await _cardRepository.fetchCardsByUser(SaveData.userId);
    try {
      emit(CardsLoadSuccessState(cards));
    } catch (e) {
      emit(CardsLoadFailState());
    }
  }
}
