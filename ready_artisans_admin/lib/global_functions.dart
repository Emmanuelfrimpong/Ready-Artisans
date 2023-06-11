String toTitleCase(String str) {
  List<String> words = str.split(' ');
  for (int i = 0; i < words.length; i++) {
    words[i] = words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
  }
  return words.join(' ');
}
