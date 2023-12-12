import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi{
  static final String veritabaniAdi = "rehber.sqlite";

  static Future<Database> veritabaniErisim() async{
    String veritabaniYolu = join(await getDatabasesPath(),veritabaniAdi);

    if(await databaseExists(veritabaniYolu)){
      print("Veritabanı daha önce kopyalanmış");
    }else{
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi"); // veri tabanına erişimi gösterir.
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes); //byte a dönüştürme
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true); //kopyalama işlemi
      print("Veritabanı kopyalandı");
    }

    return openDatabase(veritabaniYolu);
  }
}