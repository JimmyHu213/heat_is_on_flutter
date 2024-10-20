import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/views/controls/left_panel.dart';
import 'package:heat_is_on_flutter/views/controls/right_panel.dart';
import 'package:heat_is_on_flutter/widgets/center_view.dart';
import 'package:provider/provider.dart';

class ControlView extends StatefulWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  @override
  void initState() {
    super.initState();
    Provider.of<TownModel>(context, listen: false).fetchTowns();
  }

  @override
  Widget build(BuildContext context) {
    final TownModel townModel = Provider.of<TownModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Controls',
          style: TextStyle(
            color: secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: townModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : SingleChildScrollView(
              child: CenterView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: LeftPanel(),
                        ),
                        const VerticalDivider(
                          width: 1,
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        const Expanded(
                          child: RightPanel(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
