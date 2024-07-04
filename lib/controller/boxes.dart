import 'package:hive/hive.dart';
import 'package:iris/controller/save_details.dart';

class Boxes {
  static void init() {
    Hive.registerAdapter(SaveDetailsAdapter());
  }

  //open hive box here
  static Box<SaveDetails> getSaveDetails() {
    return Hive.box<SaveDetails>('saveDetails');
  }
}
