import 'package:flutter/material.dart';
import '../../domain/models/address_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userName;
  String? _userEmail;
  List<AddressModel> _addresses = [
    AddressModel(
      id: '1',
      label: 'Home Address',
      fullName: 'John Doe',
      street: 'No. 24, Oxford Street',
      city: 'Accra, Ghana',
      phoneNumber: '+233 50 000 0000',
      isDefault: true,
    ),
    AddressModel(
      id: '2',
      label: 'Office Address',
      fullName: 'John Doe',
      street: 'Hilcom Plaza, Floor 4',
      city: 'Kumasi, Ghana',
      phoneNumber: '+233 24 111 2222',
      isDefault: false,
    ),
  ];

  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  List<AddressModel> get addresses => _addresses;

  void login(String email, String password) {
    _isLoggedIn = true;
    _userName = 'John Doe';
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }

  void addAddress(AddressModel address) {
    if (address.isDefault) {
      _addresses = _addresses.map((a) => a.copyWith(isDefault: false)).toList();
    }
    _addresses.add(address);
    notifyListeners();
  }

  void updateAddress(AddressModel updatedAddress) {
    if (updatedAddress.isDefault) {
      _addresses = _addresses.map((a) => a.copyWith(isDefault: false)).toList();
    }
    final index = _addresses.indexWhere((a) => a.id == updatedAddress.id);
    if (index != -1) {
      _addresses[index] = updatedAddress;
      notifyListeners();
    }
  }

  void removeAddress(String id) {
    _addresses.removeWhere((a) => a.id == id);
    if (_addresses.isNotEmpty && !_addresses.any((a) => a.isDefault)) {
      _addresses[0] = _addresses[0].copyWith(isDefault: true);
    }
    notifyListeners();
  }
}
