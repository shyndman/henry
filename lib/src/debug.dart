import 'package:petitparser/petitparser.dart';

extension LabeledParserExtension<T> on Parser<T> {
  Parser<T> label(String label) => LabeledParser<T>(label, this);
}

class LabeledParser<T> extends DelegateParser<T> {
  LabeledParser(this.label, Parser<T> delegate) : super(delegate);
  final String label;

  @override
  Result<T> parseOn(Context context) => delegate.parseOn(context);

  @override
  DelegateParser<T> copy() => LabeledParser(label, delegate);

  @override
  String toString() => '$label ↴';
}
