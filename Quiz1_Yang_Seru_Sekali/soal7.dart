void main() {
  List<int> a = [1, 3, 5, 7];
  List<int> b = [2, 4, 6, 8];
  List<int> gabungan = [...a, ...b];

  for (int i = 0; i < gabungan.length; i++) {
    for (int j = 0; j < gabungan.length - 1 - i; j++) {
      if (gabungan[j] > gabungan[j + 1]) {
        int temp = gabungan[j];
        gabungan[j] = gabungan[j + 1];
        gabungan[j + 1] = temp;
      }
    }
  }

  print(gabungan);
  print(gabungan[gabungan.length - 2]);
}
