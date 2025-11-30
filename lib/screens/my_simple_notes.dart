import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../models/note_model.dart';

class MySimpleNotes extends StatefulWidget {
  const MySimpleNotes({super.key});

  @override
  State<MySimpleNotes> createState() => _MySimpleNotesState();
}

class _MySimpleNotesState extends State<MySimpleNotes> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  //Membuat fungsi untuk menampilkan form tambah catatan
  void _showForm() {
    //bersihkan input field setiap kali form dibuka
    _titleController.clear();
    _contentController.clear();

    showModalBottomSheet(
      context: context, 
      elevation: 5,
      //agar form bisa full screen saat keyboard muncul
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15, 
          left: 15, 
          right: 15,
          //Padding bawah mengikuti tinggi keyboard agar form tidak tertutup
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Content'),
              maxLines: 3, //untuk memperluas area ketikan
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                //1. mengambil teks dari controller
                String title = _titleController.text;
                String content = _contentController.text;

                if(title.isNotEmpty && content.isNotEmpty) {
                  //2. menyimpan teks yang diambil tadi ke database
                  await DatabaseHelper.instance.create(
                    Note(title: title, content: content)
                  );

                  //3. menutup form dan me-refresh UI
                  Navigator.of(context).pop();
                  setState(() {});
                }
              },
              child: Text('Save')
            )
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Notes with SQLite'),
      ),
      body: FutureBuilder<List<Note>>(
        future: DatabaseHelper.instance.readAllNotes(),
        builder: (context, snapshot){
          //kondisi untuk menampilkan tulisan ketika aplikasi masih loading atau ketika user sudah masuk aplikasi, tapi belum ada catatan yang dibuatnya sama sekali
          if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text(('You don\'t have any note yet'), 
          style: TextStyle(
            fontSize: 20,
          )));

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Note note = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  //bikin ikon di daerah kanan (belakang) card list tile-nya
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await DatabaseHelper.instance.delete(note.id!);
                      setState( () {} );
                    },
                  ),
                )
              );
            }
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          _showForm(); //panggil fungsi pembuka form
          setState(() {});
        },
      ),
    );
  }
}