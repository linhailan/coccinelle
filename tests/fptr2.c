int foo(int c, int d) { return 0; }

int main() {
  call(foo);
  addrcall(&foo);
}

