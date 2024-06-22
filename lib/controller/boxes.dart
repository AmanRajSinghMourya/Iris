import 'package:hive/hive.dart';
import 'package:iris/controller/save_details.dart';

class Boxes {
  static Box<SaveDetails> getSaveDetails() =>
      Hive.box<SaveDetails>('saveDetails');
}
