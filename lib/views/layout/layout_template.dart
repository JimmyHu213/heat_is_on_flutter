import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/views/home/dash_board.dart';
import 'package:heat_is_on_flutter/views/layout/mobile_page.dart';
import 'package:heat_is_on_flutter/widgets/center_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayOutTemplate extends StatefulWidget {
  const LayOutTemplate({super.key});

  @override
  State<LayOutTemplate> createState() => _LayOutTemplateState();
}

class _LayOutTemplateState extends State<LayOutTemplate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return ResponsiveBuilder(
            builder: (context, sizingInformation) => Scaffold(
                backgroundColor: primaryColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(250),
                  child: AppBar(
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/images/web-banner.png'),
                              fit: BoxFit.fill),
                          //border: Border.all(color: Colors.red, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                      backgroundColor: primaryColor,
                      elevation: 0),
                ),
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: CenterView(
                        child: sizingInformation.deviceScreenType ==
                                DeviceScreenType.mobile
                            ? Expanded(child: MobilePage())
                            : Expanded(child: DashBoard())),
                  ),
                )));
      },
    );
  }
}