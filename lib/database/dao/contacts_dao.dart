import 'package:curso_flutter_sql_lite/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import '../app_data_base.dart';

class ContactDao{
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_account_number INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _account_number = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Future<int> update(Contact contact) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contactMap = _toMap(contact);
    return db.update(
      _tableName,
      contactMap,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Contact> > findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;
  }


  Map<String, dynamic> _toMap(Contact contact) {
       final Map<String, dynamic> contactMap = Map();
    // contactMap['id'] = contact.id;
    contactMap[_name] = contact.name;
    contactMap[_account_number] = contact.accountNumber;
    return contactMap;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
      final List<Contact> contacts = [];
    for(Map<String,dynamic> row in result){
      final Contact contact = Contact(
          row[_id]??0,
          row[_name],
          row[_account_number]??0
      );
      contacts.add(contact);
    }
    return contacts;
  }
}