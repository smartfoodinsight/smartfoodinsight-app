class ApiUtils {
  static T parseData<T>(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return fromJsonT(json['data']);
  }
}
