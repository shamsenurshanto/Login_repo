class Team {
  final String id; // eg. LAL
  // final String sender_email,receiver_email,type,amount; // eg. Los Angeles
 final String sender_email;
 final String receiver_email;
 final String type;
 final int amount;
 final String mainMail;
 final String name;
//  final String nameB;
 final String Transaction_status;

  Team({
    required this.id,
    required this.sender_email,
     required this.receiver_email,
      required this.type,
       required this.amount,
       required this.mainMail,
       required this.name,
        // required this.nameB,
         required this.Transaction_status
  }
  
   
  
  );
}