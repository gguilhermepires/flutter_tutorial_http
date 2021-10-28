
class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return  "Contato(id: $id nome: $name, numeroconta:$accountNumber)";
  }

  Contact.fromJson(Map<String,dynamic> json):
      // id=json['id']?json['id'] : 0,
      id=0,
      name=json['name'],
      accountNumber=json['accountNumber'];

  Map<String, dynamic> toJson() =>{
    'id':id,
    'name':name,
    'accountNumber': accountNumber
  };

}