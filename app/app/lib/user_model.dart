class UsersModelSupport {
  String? url;
  String? text;

  UsersModelSupport({this.url, this.text});

  UsersModelSupport.fromJson(Map<String, dynamic> json) {
    url = json['url']?.toString();
    text = json['text']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'text': text,
    };
  }
}

class UsersModelData {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UsersModelData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  UsersModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    email = json['email']?.toString();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    avatar = json['avatar']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }
}

class UsersModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UsersModelData>? data;
  UsersModelSupport? support;

  UsersModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    page = json['page']?.toInt();
    perPage = json['per_page']?.toInt();
    total = json['total']?.toInt();
    totalPages = json['total_pages']?.toInt();
    if (json['data'] != null) {
      data = (json['data'] as List)
          .map((v) => UsersModelData.fromJson(v))
          .toList();
    }
    support = json['support'] != null
        ? UsersModelSupport.fromJson(json['support'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
    };
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      dataMap['support'] = support!.toJson();
    }
    return dataMap;
  }
}
