import 'package:exam/utilites/themes.dart';
import 'package:exam/view/widgets/reusable_widget/text_utils.dart';
import 'package:flutter/material.dart';

class HorizontalNumberPicker extends StatefulWidget {
  final void Function(int) onNumberChanged;

  HorizontalNumberPicker({required this.onNumberChanged});

  @override
  _HorizontalNumberPickerState createState() => _HorizontalNumberPickerState();
}

class _HorizontalNumberPickerState extends State<HorizontalNumberPicker> {
  int selectedNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          KTextWidget(
              text: "Time of exam \n   in minute",
              size: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w600),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 60,
              itemBuilder: (context, index) {
                final number = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedNumber = number;
                      widget.onNumberChanged(selectedNumber);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: selectedNumber == number
                          ? Colors
                              .blue // Change the color for the selected number
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$number',
                      style: TextStyle(
                        fontSize: 20,
                        color: selectedNumber == number
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
