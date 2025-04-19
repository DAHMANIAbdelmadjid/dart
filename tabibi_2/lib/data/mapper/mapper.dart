import 'package:tabibi_2/app/extensions.dart';
import 'package:tabibi_2/data/response/response.dart';
import 'package:tabibi_2/domain/models/models.dart';

extension LoginResponseMapper on LoginResponse? {
  Login toDomain() {
    return Login(
      statusCode: this?.statusCode.onEmpty()?? 0,
      succeeded: this?.succeeded.onEmpty()?? false,
      message: this?.message.onEmpty()?? "",
      error: this?.error.onEmpty()?? "",
      token: this?.token.onEmpty()?? "",
    );

  }
}