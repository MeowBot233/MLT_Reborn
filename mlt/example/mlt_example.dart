import 'package:mlt/mlt.dart';
import 'dart:io';

Future main() async{
  var str = stdin.readLineSync()!;
  if(!str.endsWith("Σ(っ°Д°;)っ") && !str.endsWith("_(:з」∠)_")) {
    print(await encodeString(str));
  }else {
    print(await decodeString(str));
  }
}
