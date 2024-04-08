class UserModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  int? isVerified;

  UserModel(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.password,
        this.isVerified});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['isVerified'] = this.isVerified;
    return data;
  }
}


class AuthUserModel {
  int? authenticatedUserID;

  AuthUserModel({this.authenticatedUserID});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    authenticatedUserID = json['authenticatedUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authenticatedUserID'] = this.authenticatedUserID;
    return data;
  }
}



class ExpensesModel {
  int? expenseId;
  String? expenseDate;
  String? category;
  var price;
  String? notes;
  String? icon;

  ExpensesModel(
      {this.expenseId,
        this.expenseDate,
        this.category,
        this.price,
        this.notes,
        this.icon
      });

  ExpensesModel.fromJson(Map<String, dynamic> json) {
    expenseId = json['expenseId'];
    expenseDate = json['expenseDate'];
    category = json['category'];
    price = json['price'];
    notes = json['notes'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenseId'] = this.expenseId;
    data['expenseDate'] = this.expenseDate;
    data['category'] = this.category;
    data['price'] = this.price;
    data['notes'] = this.notes;
    data['icon'] = this.icon;
    return data;
  }
}
