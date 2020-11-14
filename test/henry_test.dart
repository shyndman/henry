import 'dart:io';

import 'package:hierarchical_entity_model_recursively_yielded/src/parser.dart';
import 'package:petitparser/debug.dart';
import 'package:petitparser/petitparser.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('First Test', () {
      final henryContents = File('./test/test.henry').readAsStringSync();
      print(trace(HenryParser()).parse(henryContents).value);
    });

    test('Nested entitys', () {
      final mdm = '''



@grandparent {
  @parent {
    @child hi

    This is some text. This is some more text.
  }
}

hi hi


      ''';
      final result = HenryParser().parse(mdm);
      expect(result, isA<Success>());
      print((result as Success).value);
    });

    test('Something else', () {
      final parse = trace(HenryParser()).parse('''
foo
        @bar
    @baz foooo
    @baz {
aaaa
bbbb
ccccc @
dddd
      @attribute snaz
      eeeeee
    }

''');
      print(parse);
    });
  });
}
