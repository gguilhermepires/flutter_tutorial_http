import 'package:curso_flutter_sql_lite/database/dao/contacts_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version){
    db.execute(ContactDao.tableSql);
    }, // onDowngrade: onDatabaseDowngradeDelete,
    version: 1);
}

getDatabase() async {
  return createDatabase();
}

