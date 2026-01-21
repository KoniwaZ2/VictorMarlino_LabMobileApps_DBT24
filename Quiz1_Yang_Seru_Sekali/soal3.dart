import 'dart:math';
import 'dart:io';

void main() {
  int acak = Random().nextInt(5) + 1;
  int attempt = 1;

  stdout.write("Tebak sebuah angka antara 1 hingga 100: ");
  int tebakan = int.parse(stdin.readLineSync()!);

  while (tebakan != acak) {
    if (tebakan < acak) {
      print("Terlalu rendah! Coba lagi.");
    } else {
      print("Terlalu tinggi! Coba lagi.");
    }
    attempt++;
    stdout.write("Masukkan tebakan baru: ");
    tebakan = int.parse(stdin.readLineSync()!);
  }
  print("Selamat, berhasil menebak setelah $attempt percobaan.");
}
