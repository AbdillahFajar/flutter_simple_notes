class Note {
  final int? id;  //id boleh null
  final String title;
  final String content;

  Note({
    this.id,
    required this.title,
    required this.content
  });

  //teknik mengubah Map<String, dynamic> dari database menjadi atribut model. ini digunakan agar UI aplikasi bisa membaca (read) data dari database, sehingga data tersebut bisa tampil di UI aplikasi
  factory Note.fromMap(Map<String, dynamic>json) =>
    Note(
      id: json['id'],
      title: json['title'],
      content: json['content']
    );
  
  /*teknik mengubah atribut model menjadi Map<String, dynamic>. ini digunakan agar proses insert atau update data bisa bekerja*/
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'title': title,
      'content': content
    };
  }
}