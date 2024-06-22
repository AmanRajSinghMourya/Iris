import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iris/controller/boxes.dart';
import 'package:iris/controller/save_details.dart';
import 'package:iris/utilities/constants.dart';

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
        centerTitle: true,
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
                        Row(
                          children: [
                            Text(
                              'Product : ',
                              style: kCardTitleStyle(),
                            ),
                            Text(
                              detail.productDetail ?? 'null',
                              style: kTextFormFieldStyle(),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Region : ',
                              style: kCardTitleStyle(),
                            ),
                            Text(
                              detail.region ?? 'null',
                              style: kTextFormFieldStyle(),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Lead Status : ',
                              style: kCardTitleStyle(),
                            ),
                            Text(
                              detail.leadStatus ?? 'null',
                              style: kTextFormFieldStyle(),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Communicatoin : ',
                              style: kCardTitleStyle(),
                            ),
                            Text(
                              detail.nextCommunication ?? 'null',
                              style: kTextFormFieldStyle(),
                            )
                          ],
                        ),
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
}
