class Note{
  int id;
  String title;
  String description;
  Note(this.id,this.title,this.description);
}
Note noteFromJson(Map<String,dynamic>json){
  return Note(
    json["id"],
    json["title"],
    json["description"]
  );
}
Map<String,dynamic> tojson (Note note){
  return {
    'id':note.id,
 'title':note.title,
 'description' : note.description
};
}