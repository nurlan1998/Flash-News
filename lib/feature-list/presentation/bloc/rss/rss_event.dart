import 'package:equatable/equatable.dart';

abstract class RssEvent extends Equatable {
  const RssEvent();

  @override
  List<Object> get props => [];
}

class GetRss extends RssEvent {
  final String url;

  const GetRss({
    required this.url,
  });

  @override
  List<Object> get props => [url];
}
