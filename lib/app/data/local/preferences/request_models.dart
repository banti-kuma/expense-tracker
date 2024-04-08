class LocalDBRequestModel {
  static signupRequestModel({
    int? id,
    required var email,
    required var name,
    required var phoneNumber,
    required String? password,
    int? isVerified = 0,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null && id < 0){
      data["id"] = id;
    }
    data["name"] = name;
    data["phoneNumber"] = phoneNumber;
    data["email"] = email;
    data["password"] = password;
    data["isVerified"] = isVerified;
    return data;
  }


  static signInRequestModel({
    required var email,
    required String password,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;
    return data;
  }

  static AuthUserRequestModel({
    required var authenticatedUserID
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["authenticatedUserID"] = authenticatedUserID;
    return data;
  }


  static expenseRequestModel({
    int? expenseId,
    required var expenseDate,
    required var category,
    required var price,
    required var notes,
    required var icon,
    required var id,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (expenseId != null && expenseId < 0){
      data["expenseId"] = expenseId;
    }
    data["expenseDate"] = expenseDate;
    data["category"] = category;
    data["price"] = price;
    data["notes"] = notes;
    data["icon"] = icon;
    data["id"] = id;
    return data;
  }


}

