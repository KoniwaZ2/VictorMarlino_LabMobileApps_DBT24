// import 'dart:io';

// class Ujian {
//   String nama;
//   int nilai;

//   Ujian(this.nama, this.nilai);
// }

// void main() {
//   stdout.write("Nama siswa 1: ");
//   String nama1 = stdin.readLineSync()!;
//   stdout.write("Nilai siswa 1: ");
//   int nilai1 = int.parse(stdin.readLineSync()!);
//   Ujian siswa1 = Ujian(nama1, nilai1);
//   stdout.write("Nama siswa 2: ");
//   String nama2 = stdin.readLineSync()!;
//   stdout.write("Nilai siswa 2: ");
//   int nilai2 = int.parse(stdin.readLineSync()!);
//   Ujian siswa2 = Ujian(nama2, nilai2);
//   stdout.write("Nama siswa 3: ");
//   String nama3 = stdin.readLineSync()!;
//   stdout.write("Nilai siswa 3: ");
//   int nilai3 = int.parse(stdin.readLineSync()!);
//   Ujian siswa3 = Ujian(nama3, nilai3);

//   int rataRata = (siswa1.nilai + siswa2.nilai + siswa3.nilai) ~/ 3;
//   print("Rata-rata nilai siswa: $rataRata");
// }

import 'dart:io';

class Ujian {
  int TotalNilai = 0;
  int TotalSiswa = 0;

  void tambahNilai(int nilai) {
    TotalNilai += nilai;
    TotalSiswa++;
  }

  num rataRata() {
    return TotalNilai / TotalSiswa;
  }
}

void main() {
  Ujian ujian = Ujian();
  for (int i = 1; i <= 3; i++) {
    stdout.write("Masukkan nilai siswa ke-$i: ");
    int nilai = int.parse(stdin.readLineSync()!);

    ujian.tambahNilai(nilai);

    if (i == 3) {
      print("Rata-rata nilai dari 3 siswa adalah: ${ujian.rataRata()}");
    }
  }
}
