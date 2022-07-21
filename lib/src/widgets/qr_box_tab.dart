import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/values/values.dart';

class QrBoxTab extends StatelessWidget {
  final Color? color;
  final String title;
  
  const QrBoxTab({
    Key? key, required this.title, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 93,
        width: 100,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: grayColor),
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Column(
          mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children:  [
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Remix.home_8_line),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        title,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        textScaleFactor: 0.7,
                        textAlign: TextAlign.start,
                        //style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
        ),
      ),
    );
  }
}
