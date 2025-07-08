class ResponseModel {
  String? message;
  String? status;

  ResponseModel({this.message, this.status});

  factory ResponseModel.fromJson(Map<String, dynamic> parsedJson) => ResponseModel(
    message: parsedJson['message'],
    status: parsedJson['status'],
  );

  ResponseModel.withError(String errorValue)
      : status = 'false';
}