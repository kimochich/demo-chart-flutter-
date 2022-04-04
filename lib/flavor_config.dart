enum EnvEnum {dev,staging,prod}
enum VariableEnum {baseUrl}

class FlavorConfig {
  EnvEnum env;
  String appTitle;
  Map<VariableEnum, dynamic> variables;

  FlavorConfig(
      {required this.appTitle,
      required,
      required this.env,
      required this.variables});
}
