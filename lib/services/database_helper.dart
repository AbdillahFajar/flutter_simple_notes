import '../models/note_model.dart'; //impor model untuk mendapatkan semua atribut dari class Note
import 'package:path/path.dart'; //impor library path agar bisa menggunakan filePath untuk menggabungkan folder getDatabasePath() dengan file db-nya yang dalam kasus ini, nama db-nya adalah notes.db
import 'package:sqflite/sqflite.dart'; //impor library sqflite untuk kelola database SQLite

class DatabaseHelper {
  /*Bagian singleton, yaitu membuat satu objek agar aplikasi hanya mengakses objek tersebut untuk mengaktifkan koneksi ke database saat 
    memanggil fungsi-fungsi database yang ada. sehingga, aplikasi tidak membuat objek baru untuk mengaktifkan koneksi ke database 
    setiap kali memanggil fungsi-fungsi database tersebut yang dapat menyebabkan aplikasi crash atau hang.*/
  static final DatabaseHelper instance = DatabaseHelper._init(); //ini objek yang dimaksud, bernama instance.
  static Database? _database; //membuat objek untuk simpan koneksi database. nilai awalnya dibiarkan null terlebih dahulu, karena belum diinisialisasi

  DatabaseHelper._init(); //_init(), adalah constructor khusus untuk melengkapi pembuatan objek instance. dibuat dengan jenis private function, karena dikhususkan untuk file database_helper.dart ini aja

  //inisialisasi koneksi ke database
  Future<Database> get database async{
    if (_database != null) return _database!; //pakai koneksi db yang sudah pernah dibuka sebelumnya. ini biasanya dipakai ketika aplikasi bukan lagi dijalankan untuk pertama kalinya
    _database = await _initDB('notes.db'); //buat koneksi baru jika belum ada koneksi ke db yang dilakukan. kalau ini, biasanya dipakai ketika aplikasi pertama kali dijalankan. notes.db, adalah nama db lokalnya
    return _database!; //kembalikan database yang sudah berhasil dibuka
  }
  
  //fungsi untuk membuat database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath(); //membuat variabel untuk menyimpan database di dalam folder khusus lewat fungsi default getDatabasesPath() yang disediakan sqflite
    final path = join(dbPath, filePath); //membuat variabel untuk menggabungkan folder tersebut dengan database 'notes.db', yang diwakili dengan filePath agar sesuai dengan OS dari mobile user

    return await openDatabase(path, version: 1, onCreate:_createDB); //membuat db melalui openDatabase() sesuai dengan variabel path di atas
  }

  //fungsi untuk bikin tabel db bernama notes
  Future _createDB(Database db, int version) async {
    await db.execute
    (
      ''' CREATE TABLE notes 
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT
      ) '''
    );
  }

  //fungsi untuk masukin data ke tabel notes
  Future<int> create(Note note) async {
    final db = await instance.database;
    return await db.insert('notes',note.toMap());
  }

  //fungsi untuk menampilkan semua isi dari tabel notes. artinya, menampilkan semua notes yang telah dibuat
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final result = await db.query('notes');
    return result.map((json) => Note.fromMap(json)).toList();
  }

  //fungsi untuk menghapus notes tertentu berdasarkan id
  Future<int> delete(int id) async{
    final db = await instance.database;
    return await db.delete('notes', where:'id = ?', whereArgs:[id]);
  }
}