void main() {
  final text = 'Hello, google.com, yay https://dart.dev rocks!';
  final parts = text.parseLinks();

  for (final part in parts) {
    print(part);
  }
}

abstract class Node {
  final String content;
  Node(this.content);
}

class Text extends Node {
  Text(String content) : super(content);
  @override
  String toString() => "Text('$content')";
}

class Link extends Node {
  Link(String content) : super(content);
  @override
  String toString() => "Link('$content')";
}

extension LinkParser on String {
  List<Node> parseLinks() {
    final regex = RegExp(r'(https?:\/\/[^\s]+|[a-zA-Z0-9\-]+\.[a-zA-Z]{2,})');
    final matches = regex.allMatches(this);
    final result = <Node>[];

    int lastIndex = 0;

    for (final match in matches) {
      // Text before the link
      if (match.start > lastIndex) {
        result.add(Text(substring(lastIndex, match.start)));
      }
      // The link itself
      result.add(Link(match.group(0)!));
      lastIndex = match.end;
    }

    // Remaining text after the last link
    if (lastIndex < length) {
      result.add(Text(substring(lastIndex)));
    }

    return result;
  }
}