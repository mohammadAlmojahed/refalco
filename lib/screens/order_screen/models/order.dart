class Order {
  List<Data>? data;
  int? code;
  String? message;
  Paginate? paginate;

  Order({this.data, this.code, this.message, this.paginate});

  Order.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
    paginate = json['paginate'] != null
        ? new Paginate.fromJson(json['paginate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.paginate != null) {
      data['paginate'] = this.paginate!.toJson();
    }
    return data;
  }
}

class Data {
  String? total;
  String? createdAt;
  String? image;
  String? currency;
  String? id;
  Address? address;
  List<Items>? items;
  int? page;
  int? limit;

  Data(
      {this.total,
      this.createdAt,
      this.image,
      this.currency,
      this.id,
      this.address,
      this.items,
      this.page,
      this.limit});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    createdAt = json['created_at'];
    image = json['image'];
    currency = json['currency'];
    id = json['id'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['image'] = this.image;
    data['currency'] = this.currency;
    data['id'] = this.id;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

class Address {
  String? lat;
  String? lng;

  Address({this.lat, this.lng});

  Address.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Items {
  int? id;
  String? name;
  String? price;

  Items({this.id, this.name, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class Paginate {
  int? total;
  int? perPage;

  Paginate({this.total, this.perPage});

  Paginate.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    return data;
  }
}
