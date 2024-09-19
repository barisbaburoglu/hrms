class BillingInformationModel {
  List<BillingInformation>? billingInformations;
  int? totalCount;
  int? pageCount;

  BillingInformationModel({
    this.billingInformations,
    this.totalCount,
    this.pageCount,
  });

  BillingInformationModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      billingInformations = <BillingInformation>[];
      json['results'].forEach((v) {
        billingInformations!.add(BillingInformation.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (billingInformations != null) {
      data['results'] = billingInformations!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    return data;
  }
}

class BillingInformation {
  int? id;
  int? companyId;
  String? businessName;
  String? address;
  String? district;
  String? city;
  String? taxOrIdentificationNumber;
  String? taxOffice;
  String? createdAt;
  int? createUserID;
  String? updatedAt;
  int? updateUserID;

  BillingInformation(
      {this.id,
      this.companyId,
      this.businessName,
      this.address,
      this.district,
      this.city,
      this.taxOrIdentificationNumber,
      this.taxOffice,
      this.createdAt,
      this.createUserID,
      this.updatedAt,
      this.updateUserID});

  BillingInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    businessName = json['businessName'];
    address = json['address'];
    district = json['district'];
    city = json['city'];
    taxOrIdentificationNumber = json['taxOrIdentificationNumber'];
    taxOffice = json['taxOffice'];
    createdAt = json['createdAt'];
    createUserID = json['createUserID'];
    updatedAt = json['updatedAt'];
    updateUserID = json['updateUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (companyId != null) {
      data['companyId'] = companyId;
    }
    if (businessName != null) {
      data['businessName'] = businessName;
    }
    if (address != null) {
      data['address'] = address;
    }
    if (district != null) {
      data['district'] = district;
    }
    if (city != null) {
      data['city'] = city;
    }
    if (taxOrIdentificationNumber != null) {
      data['taxOrIdentificationNumber'] = taxOrIdentificationNumber;
    }
    if (taxOffice != null) {
      data['taxOffice'] = taxOffice;
    }
    if (createdAt != null) {
      data['createdAt'] = createdAt;
    }
    if (createUserID != null) {
      data['createUserID'] = createUserID;
    }
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt;
    }
    if (updateUserID != null) {
      data['updateUserID'] = updateUserID;
    }
    return data;
  }
}
