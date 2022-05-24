import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'application/my_app.dart';
import 'domain/database/database.dart';
import 'infrastructures/firestore_database/firestore_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
  } else {
    await Firebase.initializeApp();
  }

  // DIの設定
  GetIt.I.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  GetIt.I.registerSingleton<Database>(FirestoreDatabase());

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
