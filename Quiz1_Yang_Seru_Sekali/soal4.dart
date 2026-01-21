import 'dart:io';

void main() {
  stdout.write("Masukkan sebuah angka: ");
  int angka = int.parse(stdin.readLineSync()!);

  Prima(angka);
}

void Prima(int n) {
  if (n <= 1) {
    print("$n bukan bilangan prima.");
    return;
  }

  for (int i = 2; i <= n ~/ 2; i++) {
    if (n % i == 0) {
      print("$n bukan bilangan prima.");
      return;
    }
  }
  print("$n adalah bilangan prima.");
}
