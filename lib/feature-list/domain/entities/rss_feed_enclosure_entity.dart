import 'package:equatable/equatable.dart';

class RssFeedEnclosureEntity extends Equatable {
  final String? url;

  const RssFeedEnclosureEntity({
    required this.url,
  });

  @override
  List<Object?> get props => [url];
}

extension RssEnclosureMapper on RssFeedEnclosureEntity {
  RssFeedEnclosureEntity toEntity() {
    return RssFeedEnclosureEntity(
      url: url,
    );
  }
}
