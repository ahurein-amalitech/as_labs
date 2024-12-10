class APIResponse<T> {
  final T content;
  final String message;

  APIResponse({required this.content, required this.message});

  factory APIResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return APIResponse(
      content: fromJsonT(json['content']),
      message: json['message'],
    );
  }
}