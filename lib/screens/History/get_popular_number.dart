//MostPopular
extension MostPopularItemsExtension<E> on Iterable<E> {
  Iterable<E> mostPopularItems() {
    if (isEmpty) return [];
    final itemsCounted = <E, int>{};
    for (final e in this) {
      if (itemsCounted.containsKey(e)) {
        itemsCounted[e] = itemsCounted[e]! + 1;
      } else {
        itemsCounted[e] = 1;
      }
    }
    final highestCount = (itemsCounted.values.toList()..sort()).last;

    return itemsCounted.entries.where((e) => e.value == highestCount).map((e) {
      return e.key;
    });
  }
}

//SecondMost Popular

extension SecondMostPopularItemsExtension<E> on Iterable<E> {
  Iterable<E> secondMostPopularItems() {
    if (isEmpty) return [];
    final itemsCounted = <E, int>{};
    for (final e in this) {
      if (itemsCounted.containsKey(e)) {
        itemsCounted[e] = itemsCounted[e]! + 1;
      } else {
        itemsCounted[e] = 1;
      }
    }

    final secondHighestCount = (itemsCounted.values.toList()..sort())[1];

    return itemsCounted.entries
        .where((e) => e.value == secondHighestCount)
        .map((e) {
      return e.key;
    });
  }
}
