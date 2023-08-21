import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mockup_app/enum/enums.dart';
import 'package:mockup_app/provider/general_provider.dart';
import 'package:provider/provider.dart';

class ToolBarLayout extends StatefulWidget {
  const ToolBarLayout({super.key});

  @override
  State<ToolBarLayout> createState() => _ToolBarLayoutState();
}

class _ToolBarLayoutState extends State<ToolBarLayout> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<ToolsProvider>(builder: (context, model, child) {
      return Column(
        children: [
          Row(
            children: List.generate(PlatformType.values.length, (index) {
              final platform = PlatformType.values[index];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    model.switchPlatform(platform);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: model.selectedPlatform == platform ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      platform.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              );
            }),
          ),
          const Divider(),
          Row(
            children: List.generate(MockUpLayoutType.values.length, (index) {
              final type = MockUpLayoutType.values[index];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    model.changeLayout(type);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: model.selectedMockupLayout == type ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      type.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              );
            }),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              model.pickAppImage();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Upload App Image',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showColorPicker(true, model);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Background color',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showColorPicker(false, model);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Text color',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter Title',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                model.insertText(0, value);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter Subtitle',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                model.insertText(1, value);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Width(px)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      model.changeDimension(0, value);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Height(px)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      model.changeDimension(1, value);
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              model.captureAndSaveMockup();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              margin: const EdgeInsets.only(left: 10),
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }));
  }

  void showColorPicker(bool isBG, ToolsProvider model) {
    Color pickerColor = const Color(0xff443a49);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Pick color"),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: (color) {
                  setState(() => pickerColor = color);
                },
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (isBG) {
                      //change bg color
                      model.changeBgColor(pickerColor);
                    } else {
                      //change text color
                      model.changeTextColor(pickerColor);
                    }

                    Navigator.pop(context);
                  },
                  child: const Text("Done"))
            ],
          );
        });
  }
}
