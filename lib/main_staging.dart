import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trakk/src/.env.dart';
import 'package:trakk/src/home.dart';
import 'package:trakk/src/utils/singleton_data.dart';
import 'package:uploadcare_client/uploadcare_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SingletonData.singletonData.initBaseURL('https://api.staging.trakkhq.com/');
  SingletonData.singletonData.initSocketURL('https://api.staging.trakkhq.com');
  SingletonData.singletonData.initImageURL('https://ucarecdn.com/');
  SingletonData.singletonData.initIsDebug(true);
  SingletonData.singletonData
      .initUploadCareClient(UploadcareClient.withSimpleAuth(
    publicKey: uploadCarePublicKey,
    privateKey: uploadCarePrivateKey,
    apiVersion: 'v0.7',
  ));

  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  // await dotenv.load(fileName: ".env");

  await dotenv.load(fileName: ".env");
  //await dotenv.load(fileName: ".env");
  runApp(const Home());
}
