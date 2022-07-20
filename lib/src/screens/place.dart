// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:google_place/google_place.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await DotEnv().load('.env');
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late GooglePlace googlePlace;
//   List<AutocompletePrediction> predictions = [];

//   @override
//   void initState() {
//     String apiKey = "AIzaSyBvxkb0Gv6kwpiplPtmeQZhG4_V-KvLZ1U";
//     googlePlace = GooglePlace(apiKey);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 decoration: const InputDecoration(
//                   labelText: "Search",
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.blue,
//                       width: 2.0,
//                     ),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.black54,
//                       width: 2.0,
//                     ),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   if (value.isNotEmpty) {
//                     autoCompleteSearch(value);
//                   } else {
//                     if (predictions.length > 0 && mounted) {
//                       setState(() {
//                         predictions = [];
//                       });
//                     }
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: predictions.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: const CircleAvatar(
//                         child: Icon(
//                           Icons.pin_drop,
//                           color: Colors.white,
//                         ),
//                       ),
//                       title: Text(predictions[index].description.toString()),
//                       onTap: () {
//                         debugPrint(predictions[index].placeId);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailsPage(
//                               placeId: predictions[index].placeId.toString(),
//                               googlePlace: googlePlace,
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 10, bottom: 10),
//                 child: Image.asset("assets/powered_by_google.png"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void autoCompleteSearch(String value) async {
//     var result = await googlePlace.autocomplete.get(value);
//     if (result != null && result.predictions != null && mounted) {
//       setState(() {
//         predictions = result.predictions!;
//       });
//     }
//   }
// }

// class DetailsPage extends StatefulWidget {
//   final String placeId;
//   final GooglePlace googlePlace;

//   DetailsPage({Key? key, required this.placeId, required this.googlePlace}) : super(key: key);

//   @override
//   _DetailsPageState createState() =>
//       _DetailsPageState(this.placeId, this.googlePlace);
// }

// class _DetailsPageState extends State<DetailsPage> {
//   final String placeId;
//   final GooglePlace googlePlace;

//   _DetailsPageState(this.placeId, this.googlePlace);

//   DetailsResult detailsResult;
//   List<Uint8List> images = [];

//   @override
//   void initState() {
//     getDetils(this.placeId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Details"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueAccent,
//         onPressed: () {
//           getDetils(this.placeId);
//         },
//         child: const Icon(Icons.refresh),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: images.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 250,
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Image.memory(
//                             images[index],
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: ListView(
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: const Text(
//                           "Details",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       detailsResult != null && detailsResult.types != null
//                           ? Container(
//                               margin: const EdgeInsets.only(left: 15, top: 10),
//                               height: 50,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: detailsResult.types?.length,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     margin: const EdgeInsets.only(right: 10),
//                                     child: Chip(
//                                       label: Text(
//                                         detailsResult.types![index],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       backgroundColor: Colors.blueAccent,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           : Container(),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.location_on),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult.formattedAddress != null
//                                 ? 'Address: ${detailsResult.formattedAddress}'
//                                 : "Address: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.location_searching),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult.geometry != null &&
//                                     detailsResult.geometry?.location != null
//                                 ? 'Geometry: ${detailsResult.geometry!.location!.lat.toString()},${detailsResult.geometry!.location!.lng.toString()}'
//                                 : "Geometry: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.timelapse),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult.utcOffset != null
//                                 ? 'UTC offset: ${detailsResult.utcOffset.toString()} min'
//                                 : "UTC offset: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: const Icon(Icons.rate_review),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult.rating != null
//                                 ? 'Rating: ${detailsResult.rating.toString()}'
//                                 : "Rating: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: const Icon(Icons.attach_money),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                     detailsResult.priceLevel != null
//                                 ? 'Price level: ${detailsResult.priceLevel.toString()}'
//                                 : "Price level: null",
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 20, bottom: 10),
//                 child: Image.asset("assets/powered_by_google.png"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void getDetils(String placeId) async {
//     var result = await this.googlePlace.details.get(placeId);
//     if (result != null && result.result != null && mounted) {
//       setState(() {
//         detailsResult = result.result!;
//         images = [];
//       });

//       if (result.result!.photos != null) {
//         for (var photo in result.result!.photos!) {
//           getPhoto(photo.photoReference.toString());
//         }
//       }
//     }
//   }

//   void getPhoto(String photoReference) async {
//     var result = await this.googlePlace.photos.get(photoReference, null!, 400);
//     if (result != null && mounted) {
//       setState(() {
//         images.add(result);
//       });
//     }
//   }
// }