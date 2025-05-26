import 'package:flutter/material.dart';
import 'DB.dart';
import 'String_Utils.dart';

class DisplayFavUserProfiles extends StatefulWidget {
  const DisplayFavUserProfiles({super.key});

  @override
  State createState() => _DisplayFavUserProfilesState();
}

class _DisplayFavUserProfilesState extends State<DisplayFavUserProfiles> {
  //region LocalDB
  //For LocalDatabase
  DB myDatabase = DB();
  //endregion
  List<Map<String, dynamic>> currentUsersList = [];
  List<Map<String, dynamic>> favUsers = [];
  List<Map<String, dynamic>> filteredFavUsers = [];
  TextEditingController searchController = TextEditingController();
  bool isUserMale = true;

  @override
  void initState() {
    super.initState();
    loadFavUsers();
  }

  Future<void> loadFavUsers() async {
    //region LocalDB
    //with LocalDataBase
    await myDatabase.fetchUsersFromUsersTable();
    fetchFavUsers();
    //endregion
  }

  //region LocalDB
  Future<void> fetchFavUsers() async {
    setState(() {
      favUsers = myDatabase.usersList.where((user) => user[ISUSERFAV] == 1).toList();
      filteredFavUsers = List.from(favUsers); // Initialize filtered list with all favorite users
    });
  }
  //endregion

  Future<void> fetchFavUsersWithAPI() async {
    favUsers = currentUsersList.where((user) => user[ISUSERFAV] == true).toList();
    print(":::Fav Users $favUsers");
    filteredFavUsers = List.from(favUsers);
  }

  void searchUser(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFavUsers = List.from(favUsers); // If search is empty, show all favorite users
      } else {
        filteredFavUsers = favUsers
            .where((user) =>
            user[FULLNAME].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Row for Favorite User Profiles
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0XFF800f2f).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_outlined,
                      size: 40,
                      color: Color(0XFF800f2f),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Favorite Profiles',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'List of your favorite users',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Search Bar
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    searchUser(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search user",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF800f2f)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF800f2f), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(Icons.search, color: Color(0XFF590d22), size: 35),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        searchUser("");
                      },
                      icon: Icon(Icons.cancel_outlined, color: Color(0XFF590d22)),
                    ),
                  ),
                )),
            FutureBuilder(future: loadFavUsers(), builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Expanded(child: Center(child: CircularProgressIndicator(color: Color(0XFF590d22),)));
              }
              else{
                return Expanded(
                    child: filteredFavUsers.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border, size: 100, color: Color(0XFF590d22).withOpacity(0.4)),
                          Text(
                            'No favorite profiles available.',
                            style: TextStyle(fontSize: 18, color: Color(0XFF590d22).withOpacity(0.4)),
                          )],
                      ),
                    )
                        : ListView.builder(
                      itemCount: filteredFavUsers.length,
                      itemBuilder: (context, index) {
                        var user = filteredFavUsers[index];
                        bool isUserMale = user[GENDER] == "Male";
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0XFFc9184a).withOpacity(0.1),
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  _buildUserAvatar(user[FULLNAME]),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user[FULLNAME],
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              isUserMale ? Icons.male : Icons.female,
                                              size: 18,
                                              color: Color(0XFF800f2f),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              user[GENDER],
                                              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () async {
                                          //region LocalDB
                                          // int userId = user['id'];
                                          // int newFavStatus = (user[ISUSERFAV] == 1) ? 0 : 1;
                                          // await myDatabase.makeUserFav(userId, newFavStatus);
                                          // await fetchFavUsers();
                                          //endregion
                                          int userId = user['id'];
                                          int newFavStatus = (user[ISUSERFAV] == 1) ? 0 : 1;
                                          showDialog(context: context, builder: (context) {
                                            return Center(child: Expanded(child: CircularProgressIndicator(color: Color(0XFF590d22),)));
                                          },);
                                          await myDatabase.makeUserFav(userId, newFavStatus);
                                          await loadFavUsers();
                                          Navigator.of(context).pop();
                                          setState(() {

                                          });
                                        },
                                        icon: (user[ISUSERFAV] == true)
                                            ? Icon(Icons.favorite, color: Colors.redAccent, size: 26)
                                            : Icon(Icons.favorite_outline_rounded, color: Colors.brown[700], size: 28),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            _showFullDetailsBottomSheet(context, user);
                          },
                        );
                      },
                    )
                );
              }

            },)
          ],
        ),
      ),
    );
  }

  // Helper widget for circular user avatar
  Widget _buildUserAvatar(String fullName) {
    String firstLetter = fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';
    return CircleAvatar(
      radius: 28,
      backgroundColor: Color(0XFFa4133c),
      child: Text(
        firstLetter,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Function to show the bottom sheet for full details
  void _showFullDetailsBottomSheet(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0XFFfff0f3).withOpacity(0.98),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circular Avatar at the top
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0XFF800f2f).withOpacity(0.2),
                    child: Text(
                      user[FULLNAME].toString().isNotEmpty ? user[FULLNAME][0].toUpperCase() : '?',
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0XFF800f2f),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "User Details",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0XFF800f2f)),
                  ),
                ),
                Divider(
                  color: Color(0XFF800f2f),
                  thickness: 1.5,
                ),
                SizedBox(height: 10),
                _buildDetailRow(Icons.person_outline, "Full Name", user[FULLNAME]),
                SizedBox(height: 10),
                _buildDetailRow(Icons.phone_android_outlined, "Phone Number", user[PHONE]),
                SizedBox(height: 10),
                _buildDetailRow(Icons.email_outlined, "Email", user[EMAIL]),
                SizedBox(height: 10),
                _buildDetailRow(Icons.cake_outlined, "Date of Birth", user[DOB]),
                SizedBox(height: 10),
                // Gender-specific icon
                _buildDetailRow(
                  user[GENDER].toString().toLowerCase() == 'male' ? Icons.male : Icons.female,
                  "Gender",
                  user[GENDER],
                ),
                SizedBox(height: 10),
                _buildDetailRow(Icons.place_outlined, "City", user[CITY]),
                SizedBox(height: 10),
                _buildDetailRow(Icons.sports_esports_outlined, "Hobbies", user[HOBBIES]),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0XFF800f2f)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper widget to build a detail row with icon
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Color(0XFF800f2f), size: 28),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Color(0XFF800f2f),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}