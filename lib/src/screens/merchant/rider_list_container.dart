import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trakk/src/models/merchant/get_riders_for_merchant_response.dart';
import 'package:trakk/src/values/values.dart';

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
        padding: const EdgeInsets.only(top: 12.0, left: 25, right: 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(
                  height: 5,
                ),
                Text(
                  'View detail',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
