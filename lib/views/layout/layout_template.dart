import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/views/home/dash_board.dart';
import 'package:heat_is_on_flutter/views/layout/header.dart';
import 'package:heat_is_on_flutter/views/layout/mobile_page.dart';
import 'package:heat_is_on_flutter/widgets/center_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;

class LayOutTemplate extends StatefulWidget {
  const LayOutTemplate({super.key});

  @override
  State<LayOutTemplate> createState() => _LayOutTemplateState();
}

class _LayOutTemplateState extends State<LayOutTemplate> {
  String _loadingMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initializeTowns();
  }

  Future<void> _initializeTowns() async {
    final townModel = Provider.of<TownModel>(context, listen: false);

    try {
      //await townModel.resetTowns();
      await townModel.fetchTowns();

      print('Initialized Towns:');
      for (var town in townModel.towns) {
        print('ID: ${town.id}');
        print('Name: ${town.name}');
        print('Effort Points: ${town.effortPoints}');
        print('Bush Fire: ${town.bushFire.toJson()}');
        print('Flood: ${town.flood.toJson()}');
        print('Storm Surge: ${town.stormSurge.toJson()}');
        print('Heatwave: ${town.heatwave.toJson()}');
        print('Biodiversity: ${town.biodiversity.toJson()}');
        print('---');
      }
    } catch (e) {
      print('Error initializing towns: $e');
      //setLoadingMessage('Error initializing towns. Please try again.');
      // You might want to show an error dialog here
    } finally {
      townModel.isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TownModel>(
      builder: (context, townModel, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(250),
            child: Header(),
          ),
          body: townModel.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                      SizedBox(height: 20),
                      Text(_loadingMessage,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
              : ResponsiveBuilder(
                  builder: (context, sizingInformation) {
                    return SingleChildScrollView(
                      child: SafeArea(
                        child: CenterView(
                          child: sizingInformation.deviceScreenType ==
                                      DeviceScreenType.mobile ||
                                  sizingInformation.deviceScreenType ==
                                      DeviceScreenType.tablet
                              ? MobilePage()
                              : DashBoard(),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
