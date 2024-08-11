class AppConfigurationModel {
  bool? enableApp;

  AppConfigurationModel({this.enableApp});

  AppConfigurationModel.fromJson(Map<String, dynamic> json) {
    enableApp = json['enableApp'];
  }

  bool get isAppEnabled => enableApp ?? false;
}
