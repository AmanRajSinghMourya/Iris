import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iris/controller/boxes.dart';
import 'package:iris/controller/save_details.dart';
import 'package:iris/utilities/constants.dart';
import 'package:iris/views/edit_form.dart';

class ViewSavedDetails extends StatefulWidget {
  const ViewSavedDetails({super.key});

  @override
  State<ViewSavedDetails> createState() => _ViewSavedDetailsState();
}

class _ViewSavedDetailsState extends State<ViewSavedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        backgroundColor: kBackgroundColor,
      ),
      body: ValueListenableBuilder(
        valueListenable: Boxes.getSaveDetails().listenable(),
        builder: (context, Box<SaveDetails> box, _) {
          final details = box.values.toList().cast<SaveDetails>();
          return ListView.builder(
            itemCount: details.length,
            itemBuilder: (context, index) {
              final detail = details[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  color: cardBackgroundColor,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailRow(detail.cardData!, "Card Data : "),
                        detailRow(detail.productDetail!, 'Product Detail : '),
                        detailRow(detail.region!, 'Region : '),
                        detailRow(detail.leadStatus!, 'Lead Status : '),
                        detailRow(
                            detail.nextCommunication!, 'Communicatoin : '),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditForm(
                                    details: detail,
                                  ),
                                ));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                detail.delete();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Padding detailRow(
    String detail,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kCardTitleStyle(),
          ),
          Expanded(
            child: Text(
              detail,
              style: kTextFormFieldStyle(),
              maxLines: 7,
            ),
          )
        ],
      ),
    );
  }
}
