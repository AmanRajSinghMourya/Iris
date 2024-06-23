import 'package:flutter/material.dart';
import 'package:iris/controller/save_details.dart';
import 'package:iris/utilities/button_widget.dart';
import 'package:iris/utilities/constants.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key, required this.details});
  final SaveDetails details;

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final productDetail = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<String?> _selectedRegion = ValueNotifier<String?>(null);
  final List<String> _regions = ['North', 'South', 'West', 'East', 'Central'];

  final ValueNotifier<String?> nextCommunication = ValueNotifier<String?>(null);
  final List<String> nextCommunicationStatus = [
    'Send Brochure',
    'Send Catalog',
    'Send Product Details',
    'Schedule a Meeting',
    'Schedule a Demo',
  ];

  final List<String> leadStatusTypes = [
    'Hot - Buying Immediately',
    'Warm - Not buying immediately',
    'Cold - Not interested',
  ];
  final ValueNotifier<String?> _leadStatus = ValueNotifier<String?>(null);

  @override
  void initState() {
    productDetail.text = widget.details.productDetail!;
    _selectedRegion.value = widget.details.region!;
    _leadStatus.value = widget.details.leadStatus!;
    nextCommunication.value = widget.details.nextCommunication!;
    super.initState();
  }

  void dispsose() {
    productDetail.dispose();
    _selectedRegion.dispose();
    _leadStatus.dispose();
    nextCommunication.dispose();
    super.dispose();
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.details.productDetail = productDetail.text;
        widget.details.region = _selectedRegion.value;
        widget.details.leadStatus = _leadStatus.value;
        widget.details.nextCommunication = nextCommunication.value;
      });
      widget.details.save();
      productDetail.clear();
      _selectedRegion.value = null;
      _leadStatus.value = null;
      nextCommunication.value = null;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Form',
          style: kButtonStyle(),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Products/Services Interested In?',
                              style: kLoginTermsAndPrivacyStyle(size),
                              textAlign: TextAlign.start,
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
                            customSizedBox(size),
                            Text(
                              'Visitor Region',
                              style: kLoginTermsAndPrivacyStyle(size),
                            ),
                            ValueListenableBuilder<String?>(
                              valueListenable: _selectedRegion,
                              builder: (context, selectedRegion, child) {
                                return DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.location_city,
                                    ),
                                    focusedBorder: kFocusedBorder(),
                                    hintStyle: kHintTextStyle(),
                                    hintText: 'Select region',
                                    border: kFocusedBorder(),
                                  ),
                                  value: selectedRegion,
                                  items: _regions.map((String region) {
                                    return DropdownMenuItem<String>(
                                      value: region,
                                      child: Text(region),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    _selectedRegion.value = newValue;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a region';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            customSizedBox(size),
                            Text(
                              'Lead Status',
                              style: kLoginTermsAndPrivacyStyle(size),
                            ),
                            ValueListenableBuilder<String?>(
                              valueListenable: _leadStatus,
                              builder: (context, leads, child) {
                                return DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person,
                                    ),
                                    focusedBorder: kFocusedBorder(),
                                    hintStyle: kHintTextStyle(),
                                    hintText: 'Lead Status',
                                    border: kFocusedBorder(),
                                  ),
                                  value: leads,
                                  items: leadStatusTypes.map((String region) {
                                    return DropdownMenuItem<String>(
                                      value: region,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(region),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    _leadStatus.value = newValue;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a status';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            customSizedBox(size),
                            Text(
                              'Next Communication',
                              style: kLoginTermsAndPrivacyStyle(size),
                              textAlign: TextAlign.center,
                            ),
                            ValueListenableBuilder<String?>(
                              valueListenable: nextCommunication,
                              builder: (context, lead, child) {
                                return DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.location_city,
                                    ),
                                    focusedBorder: kFocusedBorder(),
                                    hintStyle: kHintTextStyle(),
                                    hintText: 'Lead Status',
                                    border: kFocusedBorder(),
                                  ),
                                  value: lead,
                                  items: nextCommunicationStatus
                                      .map((String region) {
                                    return DropdownMenuItem<String>(
                                      value: region,
                                      child: Text(region),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    nextCommunication.value = newValue;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a status';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            customSizedBox(size),
                            CustomButton(
                              onPressed: () {
                                saveForm();
                              },
                              child: Text(
                                'Save',
                                style: kButtonStyle(),
                              ),
                              width: double.infinity,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            customSizedBox(size),
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
      ),
    );
  }
}
