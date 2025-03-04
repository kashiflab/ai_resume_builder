class ApiError {
  final String? supabaseCode;
  final int? code;
  final String? message;
  ApiError({this.code, this.supabaseCode, this.message});
}
