import 'dart:convert';

class Sms {
  final String sender;
  final String type;
  final String no;
  final String balance;
  final String money;
  final String typeOfTransaction;
  final String refno;
  final String date;

  Sms(
      {required this.sender,
      required this.type,
      required this.no,
      required this.balance,
      required this.money,
      required this.typeOfTransaction,
      required this.refno,
      required this.date});

  factory Sms.fromJson(Map<String, dynamic> json) {
    return Sms(
      sender: json['sender'],
      type: json.containsKey('type') ? json['type'] : "",
      no: json.containsKey('no') ? json['no'] : "",
      balance: json.containsKey('balance') ? json['balance'] : "",
      money: json.containsKey('money') ? json['money'] : "",
      typeOfTransaction: json.containsKey('typeOfTransaction')
          ? json['typeOfTransaction']
          : "",
      refno: json.containsKey('refno') ? json['refno'] : "",
      date: json.containsKey('date') ? json['date'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sender"] = sender;
    data["type"] = type;
    data["no"] = no;
    data["balance"] = balance;
    data["money"] = money;
    data["typeOfTransaction"] = typeOfTransaction;
    data["refno"] = refno;
    data["date"] = date;
    return data;
  }

  static Map<String, dynamic> toMap(Sms sms) => {
    'sender': sms.sender,
    'type': sms.type,
    'no': sms.no,
    'balance': sms.balance,
    'money': sms.money,
    'typeOfTransaction': sms.typeOfTransaction,
    'refno': sms.refno,
    'date' : sms.date
  };

  static String encode(List<Sms> msgs) => json.encode(
    msgs
        .map<Map<String, dynamic>>((msg) => Sms.toMap(msg))
        .toList(),
  );

  
}
