import 'dart:io';
import 'dart:math';

void main() {
  print("Selamat datang di permainan suit!");
  gameSuit();
}

void gameSuit() {
  List suit = ["Batu", "Gunting", "Kertas"];
  Random rand = Random();

  stdout.write("Silahkan pilih Batu, Gunting, atau Kertas: ");
  String? input = stdin.readLineSync();

  if (input != null &&
      (input.toLowerCase() == "batu" ||
          input.toLowerCase() == "gunting" ||
          input.toLowerCase() == "kertas")) {
    String computerChoice = suit[rand.nextInt(3)];
    print("Pilihan komputer: $computerChoice");

    if (input.toLowerCase() == computerChoice.toLowerCase()) {
      print("Hasil: Seri!");
    } else if (input.toLowerCase() == "batu" && computerChoice == "Gunting" ||
        input.toLowerCase() == "gunting" && computerChoice == "Kertas" ||
        input.toLowerCase() == "kertas" && computerChoice == "Batu") {
      print("Hasil: Kamu Menang!");
    } else {
      print("Hasil: Komputer Menang!");
    }
  } else {
    print("Pilihan tidak valid. Silahkan pilih Batu, Gunting, atau Kertas.");
  }
}
