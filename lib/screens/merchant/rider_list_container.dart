import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trakk/models/merchant/get_riders_for_merchant_response.dart';
import 'package:trakk/utils/assets.dart';
import 'package:trakk/utils/colors.dart';

class RiderListContainer extends StatelessWidget {
  final GetRidersForMerchantResponseDatum ridersForMerchantResponseDatum;

  const RiderListContainer(
    this.ridersForMerchantResponseDatum, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      decoration: const BoxDecoration(color: whiteColor, boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 230, 230, 230),
          spreadRadius: 1,
          offset: Offset(2.0, 2.0), //(x,y)
          blurRadius: 8.0,
        ),
      ]),
      margin: EdgeInsets.only(left: 22, right: 22),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: ridersForMerchantResponseDatum
                              .attributes?.userId?.data?.attributes?.avatar ??
                          '',
                      height: 45,
                      width: 45,
                      placeholder: (context, url) => Image.asset(
                        Assets.dummy_avatar,
                        height: 45,
                        width: 45,
                      ),
                      errorWidget: (context, url, err) => Image.asset(
                        Assets.dummy_avatar,
                        height: 45,
                        width: 45,
                      ),
                    ),
                    Text(
                      '${ridersForMerchantResponseDatum.attributes?.userId?.data?.attributes?.firstName ?? ''} ${ridersForMerchantResponseDatum.attributes?.userId?.data?.attributes?.lastName ?? ''}',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                    if ((ridersForMerchantResponseDatum
                                .attributes?.vehicles?.data?.length ??
                            0) >
                        0)
                      Text(
                        'Vehicle no. ${ridersForMerchantResponseDatum.attributes?.vehicles?.data?.first.attributes?.number}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    //const SizedBox(height: 10,),
                  ],
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'View detail',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
