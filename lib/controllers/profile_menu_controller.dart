import 'package:espritacademy/screens/forum/forum_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  DashboardItem({
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });
}

class ProfileMenuController extends GetxController {
  late List<DashboardItem> _allItems;
  final filteredItems = <DashboardItem>[].obs;

  final TextEditingController searchController = TextEditingController();

  final _storage = const FlutterSecureStorage();
  final userName = "".obs;
  final userImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _initializeItems();
    filteredItems.assignAll(_allItems);

    // Listen to text changes for search
    searchController.addListener(() {
      filter(searchController.text);
    });
  }

  Future<void> _loadUserData() async {
    final String? nom = await _storage.read(key: "nom");
    final String? prenom = await _storage.read(key: "prenom");
    final String? image = await _storage.read(key: "image");

    userName.value = (prenom != null || nom != null)
        ? "${prenom ?? ''} ${nom ?? ''}".trim()
        : "Utilisateur";

    if (image != null && image.isNotEmpty) {
      userImage.value = image;
    }
  }

  void _initializeItems() {
    _allItems = [
      DashboardItem(
        title: "Cours",
        icon: Icons.school,
        color: Colors.blue,
        // onTap: () => Get.to(() => CoursesListScreen()), // Omitted here
      ),
      DashboardItem(
        title: "Quiz",
        icon: Icons.quiz,
        color: Colors.pinkAccent,
        //onTap: () => Get.to(() => QuizListScreen()),
      ),
      DashboardItem(
        title: "FlashCards",
        icon: Icons.card_giftcard,
        color: Colors.purple,
        //onTap: () => Get.to(() => FlashcardListScreen()),
      ),
      DashboardItem(
        title: "Forums",
        icon: Icons.forum,
        color: Colors.red,
        onTap: () => Get.to(() => ForumListScreen()),
      ),
      DashboardItem(
        title: "Réclamation",
        icon: Icons.report,
        color: Colors.orange,
        //onTap: () => Get.to(() => ReclamationListScreen()),
      ),
      DashboardItem(
        title: "Competitions",
        icon: Icons.chat,
        color: Colors.deepPurple,
        //onTap: () => Get.to(() => ChatbotScreen()),
      ),
    ];
  }

  void filter(String query) {
    if (query.isEmpty) {
      filteredItems.assignAll(_allItems);
      return;
    }
    final lowerQuery = query.toLowerCase();
    final results = _allItems
        .where((item) => item.title.toLowerCase().contains(lowerQuery))
        .toList();
    filteredItems.assignAll(results);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// New UI: Material + InkWell + Ink for proper ripple + custom decoration
  Widget buildMenu() {
    return Obx(() {
      return GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,          // Number of items per row
          childAspectRatio: 1.0,      // Height vs width ratio
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];

          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: item.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  // Gradient for nicer look; falls back to solid color feel
                  gradient: LinearGradient(
                    colors: [
                      item.color.withOpacity(0.95),
                      item.color.withOpacity(0.75),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: item.color.withOpacity(0.35),
                      blurRadius: 14,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item.icon, size: 40, color: Colors.white),
                      const SizedBox(height: 10),
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}