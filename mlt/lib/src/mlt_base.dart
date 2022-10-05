import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'meow_map.dart';

Future<String> encode(Uint8List data, {bool compress = true}) async {
  if (compress) {
    var gzip = GZipCodec(level: ZLibOption.maxLevel);
    var compressed = Uint8List.fromList(gzip.encode(data));
    if(compressed.length < data.length) {
      data = compressed;
    } else {
      compress = false;
    }
  }
  var bits = await _toBits(data);
  String meow = "";
  for(int i = 0; i < bits.length; i+=5) {
    meow += toMeow(bits.sublist(i, i + 5));
  }
  meow += compress ? "Σ(っ°Д°;)っ" : "_(:з」∠)_";
  return meow;
}

Future<String> encodeString(String str) async {
  var data = Uint8List.fromList(utf8.encode(str));
  //_printnum(data);
  return await encode(data);
}

Future<List<bool>> _toBits(Uint8List data) async {
  int length = (8 * data.length / 5).ceil() * 5;
  var bits = List<bool>.filled(length, false);
  for(int i = 0; i < data.length; i++) {
    var byte = data[i];
    for(int t = 7; t >= 0; t--) {
      bits[8 * i + t] = byte % 2 == 1;
      byte = (byte / 2).floor();
    }
  }
  return bits;
}

Future<Uint8List> _toBytes(List<bool> bits) async {
  int length = (bits.length / 8).floor();
  var bytes = Uint8List(length);
  for(int i = 0; i < length; i++) {
    int x = 0;
    for(int t = 0; t <8; t++) {
      x *= 2;
      if(bits[i * 8 + t]) x++;
    }
    bytes[i] = x;
  }
  return bytes;
}

String toMeow(List<bool> bits) {
  int t = 0;
  for(int i = 0; i < 5; i++) {
    t *= 2;
    if(bits[i]) t++;
  }
  return meow[t]!;
}

Future<List<int>> decode(String meow) async {
  if(!meow.endsWith("Σ(っ°Д°;)っ") && !meow.endsWith("_(:з」∠)_")) throw Exception("Format error!");
  bool compress = meow.endsWith("Σ(っ°Д°;)っ");
  var buffer = StringBuffer();
  var bits = List<bool>.empty(growable: true);
  for(int i = 0; i < meow.length; i++) {
    buffer.write(meow[i]);
    if(meow[i] == '！'|| meow[i] == '？'|| meow[i] == '～'|| meow[i]=='。' || meow[i] == '!' || meow[i] == '?' || meow[i] == '~' || meow[i] == '.') {
      var str = buffer.toString();
      buffer.clear();
      int x = cat[str]!;
      var temp = List<bool>.empty(growable: true);
      for(int t = 0; t < 5; t++) {
        temp.add(x % 2 == 1);
        x = (x / 2).floor();
      }
      bits.addAll(temp.reversed);
    }
  }
  buffer.clear();
  var bytes = await _toBytes(bits);
  if(compress) return gzip.decode(bytes);
  return bytes;
}

Future<String> decodeString(String meow) async {
  var bytes = await decode(meow);
  //_printnum(bytes);
  return utf8.decode(bytes);
}

void _printnum(List<int> bytes) {
  var buffer = StringBuffer();
  for(int byte in bytes) {
    buffer.write(byte.toRadixString(2).padLeft(8, '0'));
  }
  print(buffer.toString());
}