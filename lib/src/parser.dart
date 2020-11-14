import 'package:petitparser/petitparser.dart';

import 'grammar.dart';

class HenryParser extends GrammarParser {
  HenryParser() : super(HenryParserDefinition());
}

class HenryParserDefinition extends MdmGrammarDefinition {
  @override
  Parser nodeList() {
    return super.nodeList().map((value) {
      return (value as Iterable).map((e) => e[0]).toList();
    });
  }

  @override
  Parser elementNode() {
    return super.elementNode().map((value) {
      final name = (value[2] as Token).value;
      final children = value[3];
      return ElementNode(
          name, (children as Iterable).whereType<Node>().toList());
    });
  }

  @override
  Parser inlineElementBody() {
    return super.inlineElementBody().flatten().map((value) {
      final trimmedValue = value.trimLeft();
      return trimmedValue.isNotEmpty ? [TextNode(trimmedValue)] : [];
    });
  }

  @override
  Parser blockElementBody() {
    return super.blockElementBody().map((value) {
      return value[3];
    });
  }

  @override
  Parser textNode() {
    return super.textNode().flatten().map((value) {
      return TextNode(value);
    });
  }

  @override
  Parser blankLine() {
    return super.blankLine().flatten().map((value) {
      return [
        TextNode(value.length > 1 ? value.substring(0, value.length - 1) : '')
      ];
    });
  }
}

class ElementNode extends Node {
  ElementNode(this.name, this.children);
  final String name;
  final List<Node> children;

  @override
  String toString() => 'element($name, $children)';
}

class TextNode extends Node {
  TextNode(this.value);
  final String value;

  @override
  String toString() => 'text($value)';
}

class Node {}
