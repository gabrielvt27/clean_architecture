import 'package:clean_architecture/data/http/http_client.dart';
import 'package:clean_architecture/data/http/http_error.dart';
import 'package:clean_architecture/data/models/remote_account_model.dart';
import 'package:clean_architecture/domain/entities/account_entity.dart';
import 'package:clean_architecture/domain/helpers/domain_error.dart';
import 'package:clean_architecture/domain/usecases/authentication.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();

    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );

      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized ? DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    @required this.email,
    @required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {
        'email': email,
        'password': password,
      };
}
