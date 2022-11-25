double parseToDouble({required Map response, required String key}) {
  return response.containsKey(key)
      ? (response[key] != null)
          ? (response[key] is String)
              ? double.parse(response[key] ?? "0.0")
              : (response[key] is int)
                  ? (response[key]).toDouble()
                  : (response[key] is double)
                      ? response[key]
                      : 0.0
          : 0.0
      : 0.0;
}

double? parseToDoubleNULL({required Map response, required String key}) {
  return response.containsKey(key)
      ? (response[key] != null)
          ? (response[key] is String)
              ? double.parse(response[key] ?? "0.0")
              : (response[key] is int)
                  ? (response[key]).toDouble()
                  : (response[key] is double)
                      ? response[key]
                      : null
          : null
      : null;
}

int parseToInt({required Map response, required String key}) {
  return response.containsKey(key)
      ? (response[key] != null)
          ? (response[key] is String)
              ? int.parse(response[key] ?? "0")
              : (response[key] is double)
                  ? (response[key]).round()
                  : (response[key] is int)
                      ? response[key]
                      : 0
          : 0
      : 0;
}

int? parseToIntNULL({required Map response, required String key}) {
  return response.containsKey(key)
      ? (response[key] != null)
          ? (response[key] is String)
              ? int.parse(response[key] ?? "0")
              : (response[key] is double)
                  ? (response[key]).round()
                  : (response[key] is int)
                      ? response[key]
                      : null
          : null
      : null;
}

String parseToString({required Map response, required String key}) {
  return (response.containsKey(key) && response[key] != null)
      ? (response[key] is String)
          ? response[key]
          : response[key].toString()
      : "";
}

String? parseToStringNULL({required Map response, required String key}) {
  return (response.containsKey(key) && response[key] != null)
      ? (response[key] is String)
          ? response[key]
          : response[key].toString()
      : null;
}

bool parseToBool({required Map response, required String key}) {
  return (response.containsKey(key) && response[key] != null)
      ? (response[key] is bool)
          ? response[key]
          : (response[key] is String)
              ? (response[key].contains("true"))
                  ? true
                  : false
              : (response[key] is double)
                  ? ((response[key]).round() == 1)
                      ? true
                      : false
                  : (response[key] is int)
                      ? (response[key] == 1)
                          ? true
                          : false
                      : false
      : false;
}

bool? parseToBoolNULL({required Map response, required String key}) {
  return (response.containsKey(key) && response[key] != null)
      ? (response[key] is bool)
          ? response[key]
          : (response[key] is String)
              ? (response[key].contains("true"))
                  ? true
                  : false
              : (response[key] is double)
                  ? ((response[key]).round() == 1)
                      ? true
                      : false
                  : (response[key] is int)
                      ? (response[key] == 1)
                          ? true
                          : false
                      : null
      : null;
}

num parseToNum({required Map response, required String key}) {
  return response.containsKey(key)
      ? (response[key] != null)
          ? (response[key] is String)
              ? num.parse(response[key] ?? "0")
              : (response[key] is double)
                  ? (response[key]).round()
                  : (response[key] is int)
                      ? response[key]
                      : 0
          : 0
      : 0;
}

num parseToPrice({required Map response, required String key}) {
  return parseToNum(response: response, key: key) / 100;
}
