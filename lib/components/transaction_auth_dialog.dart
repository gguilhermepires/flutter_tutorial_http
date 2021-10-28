import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({required this.onConfirm});

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: TextField(
        controller: _passwordController,
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 24, letterSpacing: 12),
      ),
      actions: [
        ElevatedButton(
          child: Text('Cancelar'),
          onPressed: ()=>  Navigator.pop(context),
          style: ButtonStyle(
            backgroundColor:  MaterialStateProperty.all<Color>(Colors.red)
          ),
        ),
        ElevatedButton(
          child: Text('Confirmar'),
          onPressed: (){
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
        ),

      ],
    );
  }
}
