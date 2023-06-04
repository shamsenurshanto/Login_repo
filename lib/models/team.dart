class Team {
  final String id; // eg. LAL
  // final String sender_email,receiver_email,type,amount; // eg. Los Angeles
 final String sender_email;
 final String receiver_email;
 final String type;
 final int amount;
 final String mainMail;
 final String name;
 final String Transaction_id;
 final String Transaction_status;
 final String Sender_status;
 final String Receiver_status;
 final String img_link;
 final String dateOfTransactions;

  Team({
    required this.id,
    required this.sender_email,
     required this.receiver_email,
      required this.type,
       required this.amount,
       required this.mainMail,
       required this.name,
        required this.Transaction_id,
         required this.Transaction_status,
        required this.Sender_status,
      required this.Receiver_status,
      required this.img_link,
      required this.dateOfTransactions
      // required this.img_link
         
  }
  
   
  
  );
  
}