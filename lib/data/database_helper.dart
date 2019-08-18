import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper()=> _instance; 

  static Database _db;

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "Data_flutter.db"); //Data klasöründeki flutter.db benim yolum.

    //asset yükle ve kopyala
    ByteData data = await rootBundle.load(join('Data','flutter.db'));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

    //kopya oluşturulan dökümanı kaydet.
    await new File(path).writeAsBytes(bytes);
    
    var ourDb = await openDatabase(path);
    return ourDb;
  }
}