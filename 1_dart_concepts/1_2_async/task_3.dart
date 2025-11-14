import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  final file = File('dummy.txt');

  if (!await file.exists()) {
    await file.writeAsString('Initial content\n');
  }

  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print('✅ Server running on http://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    final path = request.uri.path;

    if (request.method == 'GET' && path == '/read') {
      final contents = await file.readAsString();
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.text
        ..write(contents);
    }

    else if (request.method == 'POST' && path == '/write') {
      final body = await utf8.decoder.bind(request).join();

      await file.writeAsString('$body\n', mode: FileMode.append);
      request.response
        ..statusCode = HttpStatus.ok
        ..write('✅ Written to dummy.txt');
    }

    else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('404 - Not Found');
    }

    await request.response.close();
  }
}
