import 'dart:convert';
import 'dart:io';
import 'package:toml/toml.dart';
import 'package:json2yaml/json2yaml.dart';

class Request {
  final String type;
  final StreamInfo stream;
  final List<Gift> gifts;
  final DebugInfo debug;

  Request({
    required this.type,
    required this.stream,
    required this.gifts,
    required this.debug,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        type: json['type'] as String,
        stream: StreamInfo.fromJson(json['stream']),
        gifts: (json['gifts'] as List<dynamic>)
            .map((e) => Gift.fromJson(e))
            .toList(),
        debug: DebugInfo.fromJson(json['debug']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'stream': stream.toJson(),
        'gifts': gifts.map((e) => e.toJson()).toList(),
        'debug': debug.toJson(),
      };
}

class StreamInfo {
  final String userId;
  final bool isPrivate;
  final int settings;
  final String shardUrl;
  final Tariff publicTariff;
  final PrivateTariff privateTariff;

  StreamInfo({
    required this.userId,
    required this.isPrivate,
    required this.settings,
    required this.shardUrl,
    required this.publicTariff,
    required this.privateTariff,
  });

  factory StreamInfo.fromJson(Map<String, dynamic> json) => StreamInfo(
        userId: json['user_id'] as String,
        isPrivate: json['is_private'] as bool,
        settings: json['settings'] as int,
        shardUrl: json['shard_url'] as String,
        publicTariff: Tariff.fromJson(json['public_tariff']),
        privateTariff: PrivateTariff.fromJson(json['private_tariff']),
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'is_private': isPrivate,
        'settings': settings,
        'shard_url': shardUrl,
        'public_tariff': publicTariff.toJson(),
        'private_tariff': privateTariff.toJson(),
      };
}

class Tariff {
  final int id;
  final int price;
  final String duration;
  final String description;

  Tariff({
    required this.id,
    required this.price,
    required this.duration,
    required this.description,
  });

  factory Tariff.fromJson(Map<String, dynamic> json) => Tariff(
        id: json['id'] as int,
        price: json['price'] as int,
        duration: json['duration'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'duration': duration,
        'description': description,
      };
}

class PrivateTariff {
  final int clientPrice;
  final String duration;
  final String description;

  PrivateTariff({
    required this.clientPrice,
    required this.duration,
    required this.description,
  });

  factory PrivateTariff.fromJson(Map<String, dynamic> json) => PrivateTariff(
        clientPrice: json['client_price'] as int,
        duration: json['duration'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'client_price': clientPrice,
        'duration': duration,
        'description': description,
      };
}

class Gift {
  final int id;
  final int price;
  final String description;

  Gift({
    required this.id,
    required this.price,
    required this.description,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        id: json['id'] as int,
        price: json['price'] as int,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'description': description,
      };
}

class DebugInfo {
  final String duration;
  final DateTime at;

  DebugInfo({
    required this.duration,
    required this.at,
  });

  factory DebugInfo.fromJson(Map<String, dynamic> json) => DebugInfo(
        duration: json['duration'] as String,
        at: DateTime.parse(json['at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'at': at.toIso8601String(),
      };
}

Future<void> main() async {
  final file = File('request.json');
  if (!await file.exists()) {
    print('❌ File request.json not found!');
    return;
  }

  final jsonString = await file.readAsString();

  final request = Request.fromJson(jsonDecode(jsonString));

  final yamlString = json2yaml(request.toJson());

  final tomlString = TomlDocument.fromMap(request.toJson()).toString();

  print('--- YAML ---\n$yamlString');
  print('\n--- TOML ---\n$tomlString');
}
