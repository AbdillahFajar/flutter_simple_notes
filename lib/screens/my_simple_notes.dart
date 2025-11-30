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
      
    );
  }
}