class BillingInformation {
  int? id;
  int? companyId;
  String businessName;
  String address;
  String district;
  String city;
  String taxOrIdentificationNumber;
  String taxOffice;
  DateTime createdAt;
  int? createUserId;
  DateTime? updatedAt;
  int? updateUserId;

  BillingInformation({
    this.id,
    this.companyId,
    required this.businessName,
    required this.address,
    required this.district,
    required this.city,
    required this.taxOrIdentificationNumber,
    required this.taxOffice,
    required this.createdAt,
    this.createUserId,
    this.updatedAt,
    this.updateUserId,
  });

  factory BillingInformation.fromJson(Map<String, dynamic> json) {
    return BillingInformation(
      id: json['Id'],
      companyId: json['CompanyId'],
      businessName: json['BusinessName'],
      address: json['Address'],
      district: json['District'],
      city: json['City'],
      taxOrIdentificationNumber: json['TaxOrIdentificationNumber'],
      taxOffice: json['TaxOffice'],
      createdAt: DateTime.parse(json['CreatedAt']),
      createUserId: json['CreateUserID'],
      updatedAt:
          json['UpdatedAt'] != null ? DateTime.parse(json['UpdatedAt']) : null,
      updateUserId: json['UpdateUserID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'CompanyId': companyId,
      'BusinessName': businessName,
      'Address': address,
      'District': district,
      'City': city,
      'TaxOrIdentificationNumber': taxOrIdentificationNumber,
      'TaxOffice': taxOffice,
      'CreatedAt': createdAt.toIso8601String(),
      'CreateUserID': createUserId,
      'UpdatedAt': updatedAt?.toIso8601String(),
      'UpdateUserID': updateUserId,
    };
  }
}
