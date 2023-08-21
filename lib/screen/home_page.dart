import 'package:flutter/material.dart';
import 'package:mockup_app/provider/general_provider.dart';
import 'package:mockup_app/screen/preview_layout.dart';
import 'package:mockup_app/screen/toolbar_layout.dart';
import 'package:mockup_app/utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToolsProvider>(builder: (context, model, child) {
      return BusyOverlay(
        show: model.isBusy == true,
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10),
            child: const Row(
              children: [
                //preview layout

                PreviewLayout(),

                //toolbar layout
                ToolBarLayout()
              ],
            ),
          ),
        ),
      );
    });
  }
}
