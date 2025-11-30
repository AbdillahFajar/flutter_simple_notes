import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() //ini fungsi yang dijalankan hanya sekali di stateful widget
  {
    super.initState(); //ini wajib dijalankan atau wajib ada di dalam fungsi initState, untuk memastikan inisialisasi framework berjalan dengan benar
    _navigateToHome();
  }

  _navigateToHome() async { //bikin fungsi private jenis asynchronus (fungsi yang bisa menunggu proses) bernama _navigateToHome()
    await Future.delayed(const Duration(seconds: 2)); //ini untuk mengatur waktu delay atau lama dari splash screen akan muncul di layar
  if (mounted){ 
    /*selama delay, widget State<SplashScreen> mengalami beberapa kemungkinan yang membuat widget tersebut ditutup atau diganti oleh sistem flutter.
      mounted berfungsi untuk memberi tahu flutter bahwa widget State<SplashScreen> ini masih aktif meski setelah delay agar kode navigasi
      di bawah ini bisa  terpanggil, sehingga setelah splash screen muncul di layar, berikutnya akan diarahkan ke halaman home dari aplikasi.
      penggunaan mounted ini harus selalu dilakukan jika ada navigasi di fungsi jenis asynchronus.*/
      Navigator.pushReplacementNamed(context, '/home'); 
      /*ini navigasi ke home menggunakan pushReplacementNamed agar user gak bisa balik lagi nampilin splash screen setelah masuk ke halaman home.
      kenapa ada "Named"? karena route tujuannya itu punya nama, yaitu '/home'.*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/ChasquidoQik.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              'Let\'s snap together',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    );
  }
}