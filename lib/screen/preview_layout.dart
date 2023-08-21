import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:mockup_app/enum/enums.dart';
import 'package:mockup_app/provider/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class PreviewLayout extends StatefulWidget {
  const PreviewLayout({super.key});

  @override
  State<PreviewLayout> createState() => _PreviewLayoutState();
}

class _PreviewLayoutState extends State<PreviewLayout> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ToolsProvider>(builder: (context, model, child) {
        return Container(
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(color: model.bgColor.withOpacity(0.2)),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10),
          child: Screenshot(
            controller: model.screenshotController,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 20, horizontal: model.selectedPlatform == PlatformType.IOS ? 30 : 50),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: model.bgColor),
              child: Column(
                children: [
                  //Title and subtitles sac
                  Column(
                    children: [
                      Text(
                        model.titleText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: model.textColor, fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          model.subtitleText,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: model.textColor, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Expanded(
                    child: DeviceFrame(
                        device: (model.selectedPlatform == PlatformType.IOS &&
                                model.selectedMockupLayout == MockUpLayoutType.Phone)
                            ? Devices.ios.iPhone13
                            : (model.selectedPlatform == PlatformType.IOS &&
                                    model.selectedMockupLayout == MockUpLayoutType.Tablet)
                                ? Devices.ios.iPad
                                : (model.selectedPlatform == PlatformType.Android &&
                                        model.selectedMockupLayout == MockUpLayoutType.Tablet)
                                    ? Devices.android.smallTablet
                                    : Devices.android.samsungGalaxyS20,
                        screen: model.selectedImage == ''
                            ? const Center(
                                child: Text('No Image Added',
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                              )
                            : SizedBox(
                                child: Image.network(
                                  model.selectedImage,
                                  fit: BoxFit.cover,
                                ),
                              )),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
