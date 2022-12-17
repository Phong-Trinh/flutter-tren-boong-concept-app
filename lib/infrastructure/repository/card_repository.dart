import '../../domain/entity/card_entity.dart';
import '../remote_source/card_service.dart';

class CardRepository {
  Future<List<CardEntity>> fetchCardsByUser(String id) async {
    List<CardEntity> cards = [];
    try {
      cards = await CardService.getCardsByUser(id);
    } catch (e) {
      print(e);
    }
    return cards;
  }

  CardEntity fetchRandomCardByUser(String id) {
    return CardEntity(
        id: '1',
        name: 'Luffy Strawhat 1',
        urlImage:
            'https://asia-en.onepiece-cardgame.com/images/cardlist/card/OP02-013.png?20221104');
  }
}
