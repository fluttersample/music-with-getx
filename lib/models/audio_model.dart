

import 'package:get/get.dart';

class AudioModel
{
  final String? title;
  final String? displayName;
  final String? data;
  final int? id;
  final RxBool? isAddToFavorite ;

//<editor-fold desc="Data Methods">

  const AudioModel({
    this.title,
    this.displayName,
    this.data,
    this.id,
    this.isAddToFavorite,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          displayName == other.displayName &&
          data == other.data &&
          id == other.id &&
          isAddToFavorite == other.isAddToFavorite);

  @override
  int get hashCode =>
      title.hashCode ^
      displayName.hashCode ^
      data.hashCode ^
      id.hashCode ^
      isAddToFavorite.hashCode;

  @override
  String toString() {
    return 'AudioModel{' +
        ' title: $title,' +
        ' displayName: $displayName,' +
        ' data: $data,' +
        ' id: $id,' +
        ' isAddToFavorite: $isAddToFavorite,' +
        '}';
  }

  AudioModel copyWith({
    String? title,
    String? displayName,
    String? data,
    int? id,
    RxBool? isAddToFavorite,
  }) {
    return AudioModel(
      title: title ?? this.title,
      displayName: displayName ?? this.displayName,
      data: data ?? this.data,
      id: id ?? this.id,
      isAddToFavorite: isAddToFavorite ?? this.isAddToFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      '_display_name': displayName,
      '_data': data,
      '_id': id,
      'isAddToFavorite': isAddToFavorite,
    };
  }

  factory AudioModel.fromMap(Map<String, dynamic> map) {
    return AudioModel(
      title: map['title'] as String,
      displayName: map['displayName'] as String,
      data: map['data'] as String,
      id: map['id'] as int,
      isAddToFavorite: map['isAddToFavorite'] as RxBool,
    );
  }

//</editor-fold>
}