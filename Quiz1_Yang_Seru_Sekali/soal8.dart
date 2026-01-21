import 'dart:io';

void main() {
  stdout.write("Masukkan angka: ");
  int angka = int.parse(stdin.readLineSync()!);

  int faktor = 1;
  int hasilJumlahFaktor = 0;

  while (faktor <= angka) {
    if (angka % faktor == 0) {
      hasilJumlahFaktor += faktor;
    }
    faktor++;
  }

  hasilJumlahFaktor -= angka;

  if (hasilJumlahFaktor == angka) {
    print("True");
  } else {
    print("False");
  }
}
