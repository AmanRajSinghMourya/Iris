import 'package:hive/hive.dart';
part 'save_details.g.dart';

@HiveType(typeId: 0)
class SaveDetails extends HiveObject {
  @HiveField(0)
  late String? productDetail;

  @HiveField(1)
  late String? remarks;

  @HiveField(2)
  late String? region;

  @HiveField(3)
  late String? nextCommunication;

  @HiveField(4)
  late String? leadStatus;

  @HiveField(5)
  late String? cardData;
}
