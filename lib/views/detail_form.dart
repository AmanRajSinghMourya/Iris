import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iris/utilities/constants.dart';

class DetailForm extends StatefulWidget {
  const DetailForm({super.key});

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  final productDetail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<String> leadStatus = ValueNotifier<String>('');
  final remarksController = TextEditingController();

  final ValueNotifier<List<Map<String, dynamic>>> regionDetail = ValueNotifier([
    {'title': 'North', 'isChecked': false},
    {'title': 'South', 'isChecked': false},
    {'title': 'West', 'isChecked': false},
    {'title': 'East', 'isChecked': false},
    {'title': 'Central', 'isChecked': false},
  ]);

  final ValueNotifier<List<Map<String, dynamic>>> tasksNotifier =
      ValueNotifier([
    {'title': 'Send Brochure', 'isChecked': false},
    {'title': 'Send Catalog', 'isChecked': false},
    {'title': 'Send Product Details', 'isChecked': false},
    {'title': 'Schedule a Meeting', 'isChecked': false},
    {'title': 'Schedule a Demo', 'isChecked': false},
  ]);
  @override
  void dispose() {
    productDetail.dispose();
    regionDetail.dispose();
    leadStatus.dispose();
    tasksNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                    width: constraints.maxWidth * 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Text(
                            'Products/Services Interested In?',
                            style: kLoginTermsAndPrivacyStyle(size),
                            textAlign: TextAlign.center,
                          ),
                          TextFormField(
                            controller: productDetail,
                            style: kTextFormFieldStyle(),
                            decoration: InputDecoration(
                              focusedBorder: kFocusedBorder(),
                              hintStyle: kHintTextStyle(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Visitor Region',
                            style: kLoginTermsAndPrivacyStyle(size),
                            textAlign: TextAlign.center,
                          ),
                          ValueListenableBuilder<List<Map<String, dynamic>>>(
                            valueListenable: regionDetail,
                            builder: (context, tasks, child) {
                              return ListView.builder(
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text(tasks[index]['title']),
                                    value: tasks[index]['isChecked'],
                                    onChanged: (bool? value) {
                                      // Update the task's checked status and notify listeners
                                      regionDetail.value =
                                          List.from(regionDetail.value)
                                            ..[index] = {
                                              'title': tasks[index]['title'],
                                              'isChecked': value
                                            };
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Lead Status',
                            style: kLoginTermsAndPrivacyStyle(size),
                            textAlign: TextAlign.center,
                          ),
                          ValueListenableBuilder<String>(
                            valueListenable: leadStatus,
                            builder: (context, role, child) {
                              return DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  focusedBorder: kFocusedBorder(),
                                  hintStyle: kHintTextStyle(),
                                  hintText: 'Lead Status',
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                value: role,
                                items: <String>[
                                  'Hot - Buying Immediately',
                                  'Warm - Buying within 3 months',
                                  'Cold - General Enquiry',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  leadStatus.value = newValue!;
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a region';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Next Communication',
                            style: kLoginTermsAndPrivacyStyle(size),
                            textAlign: TextAlign.center,
                          ),
                          ValueListenableBuilder<List<Map<String, dynamic>>>(
                            valueListenable: tasksNotifier,
                            builder: (context, tasks, child) {
                              return ListView.builder(
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text(tasks[index]['title']),
                                    value: tasks[index]['isChecked'],
                                    onChanged: (bool? value) {
                                      // Update the task's checked status and notify listeners
                                      tasksNotifier.value =
                                          List.from(tasksNotifier.value)
                                            ..[index] = {
                                              'title': tasks[index]['title'],
                                              'isChecked': value
                                            };
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Additoinal Remarks',
                            style: kLoginTermsAndPrivacyStyle(size),
                            textAlign: TextAlign.center,
                          ),
                          TextField(
                            controller: remarksController,
                            maxLines: 5,
                            style: kTextFormFieldStyle(),
                            decoration: InputDecoration(
                              focusedBorder: kFocusedBorder(),
                              hintStyle: kHintTextStyle(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    cardBackgroundColor),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: kButtonStyle(),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
