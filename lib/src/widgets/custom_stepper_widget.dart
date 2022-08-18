import 'package:flutter/material.dart';
import 'package:trakk/src/values/values.dart';

class CustomStepperWidget extends StatelessWidget {
  final int currentPosition;
  final int length;
  final String text;

  const CustomStepperWidget(
      {this.length = 4, this.currentPosition = 0, this.text = '', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    var shortestSide = mediaQuery.size.shortestSide;
// Determine if we should use mobile layout or not. The
// number 600 here is a common breakpoint for a typical
// 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
              length,
              (index) => Expanded(
                    flex: currentPosition == index ? 3 : 1,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Divider(
                            thickness: 2.5,
                            color: currentPosition >= index
                                ? secondaryColor
                                : dividerColor,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: secondaryColor,
                                      shape: BoxShape.circle),
                                  height: 16,
                                  width: 16,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index + 1}',
                                    style: theme.textTheme.caption!.copyWith(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: kSemiBoldWeight),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Opacity(
                                opacity: currentPosition == index ? 1 : 0,
                                child: Column(
                                  children: [
                                    textWidget(context, text),
                                    const SizedBox(
                                      height: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }

  // Widget oldLayout(BuildContext context) {
  //   ThemeData theme = Theme.of(context);
  //   final bool isDark = theme.brightness == Brightness.dark;
  //
  //   return Stack(
  //     children: [
  //       const Positioned(
  //         top: 8,
  //         left: 0,
  //         right: 0,
  //         child: Divider(
  //           thickness: 2.5,
  //           indent: 24,
  //           endIndent: 24,
  //           color: dividerColor,
  //         ),
  //       ),
  //       Center(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               if (currentPosition == 1)
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       decoration: const BoxDecoration(
  //                           color: secondaryColor, shape: BoxShape.circle),
  //                       height: 25,
  //                       width: 25,
  //                       alignment: Alignment.center,
  //                       child: const Icon(
  //                         Icons.check,
  //                         color: whiteColor,
  //                         size: 18,
  //                       ),
  //                     ),
  //                     if (firstText != null) textWidget(context, firstText!)
  //                   ],
  //                 ),
  //               if (currentPosition == 0)
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       decoration: const BoxDecoration(
  //                           color: secondaryColor, shape: BoxShape.circle),
  //                       height: 25,
  //                       width: 25,
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         '1',
  //                         style: theme.textTheme.bodyText1!.copyWith(
  //                             color: whiteColor, fontWeight: kSemiBoldWeight),
  //                       ),
  //                     ),
  //                     if (firstText != null) textWidget(context, firstText!)
  //                   ],
  //                 ),
  //               if (currentPosition == 1)
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       decoration: const BoxDecoration(
  //                           color: secondaryColor, shape: BoxShape.circle),
  //                       height: 25,
  //                       width: 25,
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         '2',
  //                         style: theme.textTheme.bodyText1!.copyWith(
  //                             color: whiteColor, fontWeight: kSemiBoldWeight),
  //                       ),
  //                     ),
  //                     if (secondText != null) textWidget(context, secondText!)
  //                   ],
  //                 ),
  //               if (currentPosition == 0)
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       decoration: BoxDecoration(
  //                           color: whiteColor,
  //                           border: Border.all(
  //                             color: theme.dividerColor,
  //                           ),
  //                           shape: BoxShape.circle),
  //                       margin: const EdgeInsets.all(2),
  //                       height: 25,
  //                       width: 25,
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         '2',
  //                         style: theme.textTheme.bodyText1!.copyWith(
  //                             color: kTextColor, fontWeight: kSemiBoldWeight),
  //                       ),
  //                     ),
  //                     if (secondText != null) textWidget(context, secondText!)
  //                   ],
  //                 )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget textWidget(context, String text) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Text(
        text,
        style: theme.textTheme.caption!.copyWith(color: secondaryColor),
      ),
    );
  }
}
