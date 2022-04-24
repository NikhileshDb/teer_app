//to find the last digit of the two digit numbers from a list of numbers
List<String> getEndNumber(List<int> list) {
  List<String> newList = [];
  for (int n in list) {
    if (n.toString().substring(1).isEmpty) {
      newList.add(n.toString());
    } else {
      final x = n.toString().substring(1);
      newList.add(x);
    }
  }
  return newList;
}
