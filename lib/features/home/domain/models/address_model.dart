class AddressModel {
  final String id;
  final String label;
  final String fullName;
  final String street;
  final String city;
  final String phoneNumber;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.label,
    required this.fullName,
    required this.street,
    required this.city,
    required this.phoneNumber,
    this.isDefault = false,
  });

  AddressModel copyWith({
    String? id,
    String? label,
    String? fullName,
    String? street,
    String? city,
    String? phoneNumber,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      fullName: fullName ?? this.fullName,
      street: street ?? this.street,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
