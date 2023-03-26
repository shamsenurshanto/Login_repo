// To parse this JSON data, do
//
//     final postLoanApi = postLoanApiFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostLoanApi postLoanApiFromJson(String str) => PostLoanApi.fromJson(json.decode(str));

String postLoanApiToJson(PostLoanApi data) => json.encode(data.toJson());

class PostLoanApi {
    PostLoanApi({
        required this.data,
    });

    List<Datum> data;

    factory PostLoanApi.fromJson(Map<String, dynamic> json) => PostLoanApi(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.sender,
        required this.receiver,
        required this.id,
        required this.type,
        required this.createdBy,
        required this.amount,
        required this.senderStatus,
        required this.receiverStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.transactionStatus,
        required this.v,
    });

    Sender sender;
    Receiver receiver;
    String id;
    Type type;
    CreatedBy createdBy;
    int amount;
    SenderStatus senderStatus;
    ReceiverStatus receiverStatus;
    DateTime createdAt;
    DateTime updatedAt;
    TransactionStatus transactionStatus;
    int v;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sender: Sender.fromJson(json["sender"]),
        receiver: Receiver.fromJson(json["receiver"]),
        id: json["_id"],
        type: json["type"],
        createdBy: json["createdBy"],
        amount: json["amount"],
        senderStatus: json["senderStatus"],
        receiverStatus: json["receiverStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        transactionStatus: json["transactionStatus"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "sender": sender.toJson(),
        "receiver": receiver.toJson(),
        "_id": id,
        "type": typeValues.reverse[type],
        "createdBy": createdByValues.reverse[createdBy],
        "amount": amount,
        "senderStatus": senderStatusValues.reverse[senderStatus],
        "receiverStatus": receiverStatusValues.reverse[receiverStatus],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "transactionStatus": transactionStatusValues.reverse[transactionStatus],
        "__v": v,
    };
}

enum CreatedBy { THE_64057741_E98_FF7_AF5_A3_D8884, THE_64057706_E98_FF7_AF5_A3_D887_B }

final createdByValues = EnumValues({
    "64057706e98ff7af5a3d887b": CreatedBy.THE_64057706_E98_FF7_AF5_A3_D887_B,
    "64057741e98ff7af5a3d8884": CreatedBy.THE_64057741_E98_FF7_AF5_A3_D8884
});

class Receiver {
    Receiver({
        required this.receiverEmailPhone,
        required this.receiverId,
    });

    ReceiverEmailPhone receiverEmailPhone;
    CreatedBy receiverId;

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        receiverEmailPhone: json["receiverEmailPhone"],
        receiverId: json["receiverId"],
    );

    Map<String, dynamic> toJson() => {
        "receiverEmailPhone": receiverEmailPhoneValues.reverse[receiverEmailPhone],
        "receiverId": createdByValues.reverse[receiverId],
    };
}

enum ReceiverEmailPhone { EMPTY, THE_012573 }

final receiverEmailPhoneValues = EnumValues({
    "": ReceiverEmailPhone.EMPTY,
    "012573": ReceiverEmailPhone.THE_012573
});

enum ReceiverStatus { ACKNOWLEDGED }

final receiverStatusValues = EnumValues({
    "ACKNOWLEDGED": ReceiverStatus.ACKNOWLEDGED
});

class Sender {
    Sender({
        required this.senderEmailPhone,
        required this.senderId,
    });

    String senderEmailPhone;
    String senderId;

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        senderEmailPhone: json["senderEmailPhone"],
        senderId: json["senderId"],
    );

    Map<String, dynamic> toJson() => {
        "senderEmailPhone": senderEmailPhone,
        "senderId": senderId,
    };
}

enum SenderStatus { SENT }

final senderStatusValues = EnumValues({
    "SENT": SenderStatus.SENT
});

enum TransactionStatus { COMPLETE }

final transactionStatusValues = EnumValues({
    "COMPLETE": TransactionStatus.COMPLETE
});

enum Type { THE_63_EFBEF607_CA4144957_E03_EF }

final typeValues = EnumValues({
    "63efbef607ca4144957e03ef": Type.THE_63_EFBEF607_CA4144957_E03_EF
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
