import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/model/user_model.dart';
import 'package:totalx/service/app_service.dart';

class DataController extends ChangeNotifier {
  final imagePicker = ImagePicker();
  final DataService dataService = DataService();
  File? selectedImage;
  List<AppModel> allUsers = [];
  List<AppModel> filteredUsers = [];
  String selectedFilter = 'all';
  DocumentSnapshot? lastGoc;
  final int pageSize = 10;
  bool isLoading = false;
  bool hasMore = true;
  bool isLoadingMore = false;

  DataController() {
    fetchUsers();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  Future<void> fetchUsers({bool isLoadMore = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    try {
      final users = dataService.getUsers(
        lastDocument: isLoadMore ? lastGoc : null,
        pageSize: pageSize,
      );

      users.listen((snaphot) {
        final users = snaphot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return AppModel.fromJson(data);
        }).toList();

        hasMore = users.length == pageSize;
        if (users.isEmpty) {
          hasMore = false;
        } else {
          if (isLoadMore) {
            allUsers.addAll(users);
            log('${allUsers.length}');
          } else {
            allUsers = users;
          }
          lastGoc = snaphot.docs.isNotEmpty ? snaphot.docs.last : null;
          filterByAge();
        }
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      log('Error fetching users: $e');
      isLoading = false;
    }
  }

  Future<void> refreshUsers() async {
    lastGoc = null;
    hasMore = true;
    pageSize == 10;
    fetchUsers();
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers = List.from(allUsers);
    } else {
      // filteredUsers = allUsers
      //     .where(
      //         (user) => user.name!.toLowerCase().contains(query.toLowerCase()))
      //     .toList();
      filteredUsers = allUsers.where((user) {
        final lowerQuery = query.toLowerCase();
        return (user.name?.toLowerCase().contains(lowerQuery)??false) || 
        (user.phoneNumber?.toLowerCase().contains(lowerQuery)?? false);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> addUsersCollection({
    required String name,
    required String age,
    required String phoneNumber,
    required File imageFile,
  }) async {
    try {
      await dataService.addUser(name: name, age: age,phoneNumber: phoneNumber, imageFile: imageFile);
      refreshUsers();
    } catch (e) {
      log('Error adding user to Firestore: $e');
    }
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    filterByAge();
    notifyListeners();
  }

  void filterByAge() {
    if (selectedFilter == 'all') {
      filteredUsers = List.from(allUsers);
    } else if (selectedFilter == 'elder') {
      filteredUsers = allUsers
          .where((user) =>
              int.tryParse(user.age ?? '0') != null &&
              int.parse(user.age!) >= 60)
          .toList();
    } else if (selectedFilter == 'younger') {
      filteredUsers = allUsers
          .where((user) =>
              int.tryParse(user.age ?? '0') != null &&
              int.parse(user.age!) < 60)
          .toList();
    }
  }

  Future<void> loadMore() async {
    if (hasMore) {
      isLoadingMore = true;
      await fetchUsers(isLoadMore: true);
      isLoadingMore = false;
    }
  }
}
