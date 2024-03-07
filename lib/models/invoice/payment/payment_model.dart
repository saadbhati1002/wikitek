class InvoiceAmount {
  int? count;
  List<InvoiceAmountData>? results;

  InvoiceAmount({count, results});

  InvoiceAmount.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <InvoiceAmountData>[];
      json['results'].forEach((v) {
        results!.add(InvoiceAmountData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;

    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceAmountData {
  String? id;
  String? created;
  String? modified;
  String? dateReceived;
  String? transactionId;
  double? amount;
  String? comment;
  String? invoice;

  InvoiceAmountData(
      {id,
      created,
      modified,
      dateReceived,
      transactionId,
      amount,
      comment,
      invoice});

  InvoiceAmountData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    modified = json['modified'];
    dateReceived = json['date_received'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    comment = json['comment'];
    invoice = json['invoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['modified'] = modified;
    data['date_received'] = dateReceived;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['comment'] = comment;
    data['invoice'] = invoice;
    return data;
  }
}
