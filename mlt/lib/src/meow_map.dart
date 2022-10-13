Map<String, int> _inverse(Map<int,String> f) {
 return f.map( (k, v) => MapEntry(v, k) );
}

Map<int,String> meow = {
  0 : "!",
  1 : "?",
  2 : "~",
  3 : ".",
  4 : "nya?",
  5 : "nya~",
  6 : "nya!",
  7 : "nya.",
  8 : "！",
  9 : "？",
  10 : "～",
  11 : "。",
  12 : "nya？",
  13 : "nya～",
  14 : "nya！",
  15 : "nya。",
  16 : "喵!",
  17 : "喵?",
  18 : "喵~",
  19 : "喵.",
  20 : "喵呜?",
  21 : "喵呜~",
  22 : "喵呜!",
  23 : "喵呜.",
  24 : "喵！",
  25 : "喵？",
  26 : "喵～",
  27 : "喵。",
  28 : "喵呜？",
  29 : "喵呜～",
  30 : "喵呜！",
  31 : "喵呜。",
};

Map<String, int> cat = _inverse(meow);