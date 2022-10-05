import 'package:mlt/mlt.dart';
import 'package:test/test.dart';

Future main() async {
  group('A group of tests', () {

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () async {
      var str = "喵呜喵呜喵呜QWQ👀";
      var meow = await encodeString(str);
      
    });
  });
}
