import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/user_controller.dart';
import 'package:totalx/service/auth_service.dart';
import 'package:totalx/widgets/floating_action_button.dart';
import 'package:totalx/widgets/search_filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Cochi',
        ),
        leading: const Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        actions: [
           Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
             
              child: const Icon(Icons.logout, color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchFilterWidget(searchController: searchController),
            ),
            const SizedBox(height: 20),
            Text(
              'Users Lists',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.grey[500]),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<DataController>(
                builder: (context, homeController, child) {
                  return RefreshIndicator(
                    onRefresh: () {
                     
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (notification is ScrollEndNotification &&
                            notification.metrics.extentAfter == 0 &&
                            !homeController.isLoading &&
                            homeController.hasMore) {
                          
                        }
                        return false;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: homeController.filteredUsers.length +
                            (isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if () {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          final user = homeController.filteredUsers[index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 35,
                                backgroundImage: user.image != null
                                    ? NetworkImage(user.image!)
                                    : const AssetImage('assets/profile_icon.png')
                                        as ImageProvider,
                              ),
                              title: Text(user.name ?? ''),
                              subtitle: Text(user.age ?? ''),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActoionWidget(nameController: nameController, ageController: ageController),
    );
  }

  void _scrollListener() {
   
  }

  Future<void> _loadMoreData() async {
   
  }


}


