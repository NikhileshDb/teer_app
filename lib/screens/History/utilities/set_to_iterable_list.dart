List<dynamic> setToIterableList(List listObj) {
  List newList = listObj.expand((el) => el).toList();
  return newList;
}
