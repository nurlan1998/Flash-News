import 'dart:convert';

class ApiException implements Exception {
  final bool apiError;
  final bool statusError;

  final String? error;
  final String? errMessage;
  final int? responseStatus;

  ApiException({
    this.apiError = false,
    this.statusError = false,
    this.error,
    this.errMessage,
    this.responseStatus,
  });

  factory ApiException.fromJson(dynamic json) {
    if (json is String) json = jsonDecode(json);
    print(json['message']);
    return ApiException(
      error: json['code'],
      errMessage: json['message'],
      apiError: true,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = error;
    data['message'] = errMessage;
    data['apiError'] = apiError;
    data['statusError'] = statusError;
    data['responseStatus'] = responseStatus;
    return data;
  }

  @override
  String toString() => errMessage ?? 'NULL Error';

  String get message => errMessage ?? 'NULL Message';
}