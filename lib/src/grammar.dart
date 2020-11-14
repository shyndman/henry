import 'package:petitparser/petitparser.dart';

import 'debug.dart';

class MdmGrammar extends GrammarParser {
  MdmGrammar() : super(MdmGrammarDefinition());
}

class MdmGrammarDefinition extends GrammarDefinition {
  @override
  Parser start() {
    return (nodeList() & endOfInput().trim()).pick(0);
  }

  Parser nodeList() {
    return (node() | blankLine()).star();
  }

  Parser node() {
    return (entityNode() | textNode()) & terminator();
  }

  Parser entityNode() {
    return (nonBreakingWhitespace() &
            ENTITY_MARK() &
            IDENTIFIER() &
            (blockEntityBody() | inlineEntityBody()))
        .label('Entity node');
  }

  Parser inlineEntityBody() {
    return (nonBreakingWhitespace() & pattern('^{\n').star())
        .label('Inline entity body');
  }

  Parser blockEntityBody() {
    return (nonBreakingWhitespace() &
            char('{') &
            NEWLINE() &
            ref(nodeList) &
            nonBreakingWhitespace() &
            char('}'))
        .label('Block entity body');
  }

  Parser textNode() {
    return (nonBreakingWhitespace() & pattern('^@}\n') & pattern('^\n').star())
        .label('Text node');
  }

  Parser blankLine() {
    return nonBreakingWhitespace() & NEWLINE();
  }

  Parser space() => NON_BREAKING_WHITESPACE() | commentSingle().optional();

  Parser nonBreakingWhitespace() => NON_BREAKING_WHITESPACE().star();

  Parser commentSingle() => string('//') & Token.newlineParser().not().star();

  Parser terminator() => NEWLINE() | endOfInput();

  Parser token(Object input, [String message]) {
    if (input is Parser) {
      return input.token();
    } else if (input is String) {
      return token(input.toParser());
    } else if (input is Function) {
      return token(ref(input));
    }
    throw ArgumentError.value(input, 'invalid token parser');
  }

  Parser IDENTIFIER() => ref(token, pattern('a-zA-Z0-9\-_').plus().flatten());
  Parser NON_BREAKING_WHITESPACE() => pattern(' \t');
  Parser NEWLINE() => ref(token, '\n');
  Parser ENTITY_MARK() => ref(token, '@');
  Parser OPEN_BLOCK() => ref(token, '{');
  Parser CLOSE_BLOCK() => ref(token, '}');
}
