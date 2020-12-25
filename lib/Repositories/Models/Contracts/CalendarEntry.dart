class CalendarEntry{
  DateTime date;
  String title;
  int userid;

  CalendarEntry(this.date,this.title,this.userid);

  Map<String,dynamic> toMap(){
    return {'date':this.date, 'title':this.title, 'userid':this.userid};
  }
}