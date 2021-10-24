import 'package:curso_flutter_sql_lite/database/dao/contacts_dao.dart';
import 'package:curso_flutter_sql_lite/models/contact.dart';
import 'package:flutter/material.dart';
const appBarTitle = 'Novo contato';
const btCriar = 'Novo contato';

class ContactForm extends StatefulWidget {

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContaController = TextEditingController();
  final ContactDao _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome completo'
              ),
              style: TextStyle(
                fontSize: 24
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: TextField(
                controller: _numeroContaController,
                decoration: InputDecoration(
                    labelText: 'Número da conta'
                ),
                style: TextStyle(
                    fontSize: 24
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: (){
                    final String nome = _nomeController.text;
                    final int? numeroConta = int.tryParse(_numeroContaController.text);
                    if(numeroConta != null){
                      final Contact contact = Contact(0,nome, numeroConta);
                      _dao.save(contact).then((id) => Navigator.pop(context));
                    }
                  },
                  child: Text(btCriar),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
