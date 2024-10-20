import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/model/global_data.dart';
import 'package:heat_is_on_flutter/views/home/dash_board.dart';
import 'package:heat_is_on_flutter/views/layout/mobile_page.dart';
import 'package:heat_is_on_flutter/widgets/center_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/views/intro/intro_view.dart';
import 'package:heat_is_on_flutter/views/controls/control_view.dart';

class LayOutTemplate extends StatefulWidget {
  const LayOutTemplate({Key? key}) : super(key: key);

  @override
  State<LayOutTemplate> createState() => _LayOutTemplateState();
}

class _LayOutTemplateState extends State<LayOutTemplate> {
  final String _loadingMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initializeTowns();
    _initializeEvents();
    _initializeRounds();
    _initalizeDummy();
  }

  Future<void> _initalizeDummy() async {
    try {
      GlobalDummyTown().getTown();
      print('Initialized Dummy Town: ${GlobalDummyTown.town}');
    } catch (e) {
      print('Error initializing dummy town: $e');
    }
  }

  Future<void> _initializeRounds() async {
    final globalRound = GlobalRound();
    try {
      globalRound.getRound();
      print('Initialized Rounds: ${globalRound.getRound()}');
    } catch (e) {
      print('Error initializing rounds: $e');
    }
  }

  Future<void> _initializeEvents() async {
    final eventLog = EventLog();
    try {
      eventLog.getEventLog();
      print('Initialized Events: ${eventLog.getEventLog()}');
    } catch (e) {
      print('Error initializing events: $e');
      //setLoadingMessage('Error initializing events. Please try again.');
      // You might want to show an error dialog here
    }
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
        print('Bush Fire: ${town.bushfire.toJson()}');
        print('Flood: ${town.flood.toJson()}');
        print('Storm Surge: ${town.stormSurge.toJson()}');
        print('Heatwave: ${town.heatwave.toJson()}');
        print('Biohazard: ${town.biohazard.toJson()}');
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
          body: townModel.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.blue),
                      SizedBox(height: 20),
                      Text(_loadingMessage,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: false,
                      expandedHeight: 250,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.info_outline,
                              size: 40, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const IntroView()),
                            );
                          },
                          tooltip: 'Information',
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.person_2_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ControlView()),
                            );
                          },
                          tooltip: 'Admin Control',
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          'assets/images/web-banner.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          return SafeArea(
                            child: CenterView(
                              child: sizingInformation.deviceScreenType ==
                                          DeviceScreenType.mobile ||
                                      sizingInformation.deviceScreenType ==
                                          DeviceScreenType.tablet
                                  ? MobilePage()
                                  : DashBoard(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
