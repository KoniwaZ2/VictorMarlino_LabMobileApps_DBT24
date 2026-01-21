class Account {
  int balance = 0;

  void deposit(int amount) {
    balance += amount;
    print("Saldo sekarang: $balance");
  }

  void withdraw(int amount) {
    if (amount > balance) {
      print("Saldo tidak cukup");
      print("Saldo: $balance");
    } else {
      balance -= amount;
      print("Sisa saldo: $balance");
    }
  }
}

void main() {
  Account account = Account();

  account.deposit(1000);
  account.withdraw(500);
  account.withdraw(600);
}
