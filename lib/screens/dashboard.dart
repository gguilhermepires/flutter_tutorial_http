import 'package:curso_flutter_sql_lite/screens/transactions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contacts_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Dasboard'),
      ),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network("https://cdn.pixabay.com/photo/2021/08/07/08/50/staircase-6528080_960_720.jpg")
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:Image.asset('images/logo.png') ,
            ),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _FeatureItem('Transfer', Icons.monetization_on, onClick: _showContactsList,),
                  _FeatureItem('Transfer Feed', Icons.description, onClick: _showTransactionList,),
                ],
              ),
            ),
          ],
        ),
    );
  }
  void _showContactsList(BuildContext context){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ContactsList()
    ));
  }
  void _showTransactionList(BuildContext context){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => TransactionsList()
    ));
  }
}

class _FeatureItem extends StatelessWidget {

  final String name;
  final IconData icon;
  final Function onClick;

   _FeatureItem(this.name, this.icon, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(context),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color:Colors.white,
                  size: 24,),
                Text(name,
                  style: TextStyle(color: Colors.white, fontSize: 16),)
              ],),
          ),
        ),
      ),
    );
  }
}


