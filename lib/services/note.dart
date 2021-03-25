class Note {
  String title;
  String content;
  int id;

  Note({this.title, this.content, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title.toString(),
      'content': this.content.toString()
    };
  }
}