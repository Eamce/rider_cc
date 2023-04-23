class ChatDetail {
  final String id;
  final String transaction_no;
  final String msgbody;
  final String sender;
  final String msgdatetime;
  final String receiver;
  final String seen;
  final String seen_at;

  ChatDetail({
    required this.id,
    required this.transaction_no,
    required this.msgbody,
    required this.sender,
    required this.msgdatetime,
    required this.receiver,
    required this.seen,
    required this.seen_at,
  });

  factory ChatDetail.fromJson(Map<String, dynamic> parsedJson) {
    return ChatDetail(
      id: parsedJson['id'],
      transaction_no: parsedJson['transaction_no'],
      msgbody: parsedJson['msg_body'],
      sender: parsedJson['sender'],
      msgdatetime: parsedJson['msg_datetime'],
      receiver: parsedJson['receiver'],
      seen: parsedJson['seen'],
      seen_at: parsedJson['seen_at'],
    );
  }
}
