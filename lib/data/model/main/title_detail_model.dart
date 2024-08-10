class TitleDetailModel {
  String? title;
  String? detail;
  bool selected = false;

  TitleDetailModel({this.title, this.detail});

  TitleDetailModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['detail'] = detail;
    return data;
  }
}
