import 'dart:collection';
import 'dart:math';

class BoardId {
  final String value;
  const BoardId(this.value);

  @override
  String toString() => value;
}

class MessageId {
  final String value;
  const MessageId(this.value);

  @override
  String toString() => value;
}

class Board {
  final BoardId id;
  final String title;
  final String description;

  const Board({
    required this.id,
    required this.title,
    required this.description,
  });
}

class Message {
  final MessageId id;
  final BoardId boardId;
  final String? author;
  final String content;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.boardId,
    required this.content,
    this.author,
    required this.createdAt,
  });
}

abstract class BoardsRepository {
  Future<Board> createBoard(String title, String description);
  Future<List<Board>> getAllBoards();
  Future<Board?> getBoard(BoardId id);
}

abstract class MessagesRepository {
  Future<Message> postMessage(BoardId boardId, String content, {String? author});
  Future<List<Message>> getMessages(BoardId boardId);
}

class InMemoryBoardsRepository implements BoardsRepository {
  final _boards = <BoardId, Board>{};

  @override
  Future<Board> createBoard(String title, String description) async {
    final id = BoardId(_generateId());
    final board = Board(id: id, title: title, description: description);
    _boards[id] = board;
    return board;
  }

  @override
  Future<List<Board>> getAllBoards() async {
    return _boards.values.toList(growable: false);
  }

  @override
  Future<Board?> getBoard(BoardId id) async {
    return _boards[id];
  }

  String _generateId() => 'board_${Random().nextInt(1 << 32)}';
}

class InMemoryMessagesRepository implements MessagesRepository {
  final Map<BoardId, List<Message>> _messages = HashMap();

  @override
  Future<Message> postMessage(BoardId boardId, String content,
      {String? author}) async {
    final message = Message(
      id: MessageId(_generateId()),
      boardId: boardId,
      content: content,
      author: author?.trim().isEmpty ?? true ? null : author,
      createdAt: DateTime.now(),
    );
    _messages.putIfAbsent(boardId, () => []).add(message);
    return message;
  }

  @override
  Future<List<Message>> getMessages(BoardId boardId) async {
    return _messages[boardId] ?? [];
  }

  String _generateId() => 'msg_${Random().nextInt(1 << 32)}';
}

class MockBoardsRepository implements BoardsRepository {
  @override
  Future<Board> createBoard(String title, String description) async {
    return Board(
      id: BoardId('mock_board'),
      title: title,
      description: description,
    );
  }

  @override
  Future<List<Board>> getAllBoards() async =>
      [Board(id: BoardId('mock_board'), title: 'Mock', description: 'Test')];

  @override
  Future<Board?> getBoard(BoardId id) async =>
      Board(id: id, title: 'Mock', description: 'Fake');
}

class MockMessagesRepository implements MessagesRepository {
  @override
  Future<Message> postMessage(BoardId boardId, String content,
      {String? author}) async {
    return Message(
      id: MessageId('mock_msg'),
      boardId: boardId,
      content: content,
      author: author,
      createdAt: DateTime(2000),
    );
  }

  @override
  Future<List<Message>> getMessages(BoardId boardId) async => [
        Message(
          id: MessageId('mock_msg'),
          boardId: boardId,
          content: 'Hello mock world!',
          createdAt: DateTime(2000),
        )
      ];
}

Future<void> main() async {
  final boardsRepo = InMemoryBoardsRepository();
  final messagesRepo = InMemoryMessagesRepository();

  final board = await boardsRepo.createBoard('General', 'Talk about anything');
  await messagesRepo.postMessage(board.id, 'First post!', author: 'Alice');
  await messagesRepo.postMessage(board.id, 'Hi everyone!');

  final boards = await boardsRepo.getAllBoards();
  final messages = await messagesRepo.getMessages(board.id);

  print('Boards:');
  for (var b in boards) {
    print('  - ${b.title}: ${b.description}');
  }

  print('\nMessages in "${board.title}":');
  for (var m in messages) {
    print('  [${m.author ?? "Anonymous"}] ${m.content}');
  }
}
