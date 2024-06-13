import 'package:flutter/material.dart';
import 'package:iris/controller/auth_controller.dart';
import 'package:iris/utilities/constants.dart';
import 'package:iris/views/signup_view.dart';
import 'package:share_plus/share_plus.dart';

class DetailForm extends StatefulWidget {
  const DetailForm({super.key});

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  final productDetail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final remarksController = TextEditingController();
  AuthenticationController authenticationController =
      AuthenticationController();
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
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  Future<void> shareFrom() async {
    if (_formKey.currentState!.validate()) {
      final String shareContent =
          'Product Detail: ${productDetail.text}\nRegion: ${_selectedRegion.value}\nLead Status:${_leadStatus.value}\nNext Communication:  ${nextCommunication.value}\nRemarks:  ${remarksController.text}';
      print(shareContent);
      isLoading.value = true;
      await Share.share(shareContent);
      //clear all the fields
      isLoading.value = false;
      productDetail.clear();
      _selectedRegion.value = null;
      _leadStatus.value = null;
      nextCommunication.value = null;
      remarksController.clear();
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please fill all the fields'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            );
          });
    }
  }

  Future<void> addOtherLead() async {
    Navigator.of(context).pop();
  }

  Future<void> logout() async {
    authenticationController.logout();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignUpView(),
      ),
    );
    //logout the user
  }

  @override
  void dispose() {
    authenticationController.dispose();
    _leadStatus.dispose();
    _selectedRegion.dispose();
    productDetail.dispose();
    nextCommunication.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 30.0, bottom: 20.0),
                        child: Text(
                          "Details Form",
                          style: kLoginTitleStyle(size),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 30.0, bottom: 20.0),
                        child: IconButton(
                          onPressed: () {
                            logout();
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
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
                          SizedBox(
                            height: size.height * 0.03,
                          ),
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
                          SizedBox(
                            height: size.height * 0.03,
                          ),
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
                          SizedBox(
                            height: size.height * 0.03,
                          ),
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
                            maxLines: 2,
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
                              child: ValueListenableBuilder<bool>(
                                valueListenable: isLoading,
                                builder: (context, loading, child) {
                                  return loading
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          'Submit',
                                          style: kButtonStyle(),
                                        );
                                },
                              ),
                              onPressed: () {
                                shareFrom();
                              },
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
                                'Add Other Lead',
                                style: kButtonStyle(),
                              ),
                              onPressed: () {
                                addOtherLead();
                              },
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
