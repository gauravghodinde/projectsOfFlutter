void main() {
  print("hello world");
  var result = fibonacci(6);
  print(result);
}

int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}
