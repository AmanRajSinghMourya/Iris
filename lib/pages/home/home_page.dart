import 'package:flutter/material.dart';
import 'package:iris/pages/home/widgets/header_widget.dart';
import 'package:iris/responsive.dart';
import 'package:iris/pages/home/widgets/activity_details_card.dart';
import 'package:iris/pages/home/widgets/bar_graph_card.dart';
import 'package:iris/pages/home/widgets/line_chart_card.dart';
import 'package:iris/widgets/profile/widgets/scheduled.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomePage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    SizedBox _height(BuildContext context) => SizedBox(
          height: Responsive.isDesktop(context) ? 30 : 20,
        );

    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 15 : 18),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Header(scaffoldKey: scaffoldKey),
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Scheduled(),
              _height(context),
              const ActivityDetailsCard(),
              _height(context),
              LineChartCard(),
              _height(context),
              BarGraphCard(),
              _height(context),
            ],
          ),
        )));
  }
}
