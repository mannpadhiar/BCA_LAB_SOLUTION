import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'DB.dart';
import 'String_Utils.dart';
import 'package:intl/intl.dart';
class UserProfiles extends StatefulWidget {
  const UserProfiles({super.key});

  @override
  State createState() => _UserProfilesState();
}

class _UserProfilesState extends State<UserProfiles> {
  DB myDatabase = DB();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> currentUsersList = [];
  List<Map<String, dynamic>> searchUsersList = [];
  TextEditingController SearchController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _religion = TextEditingController();
  int? age;
  int currentYear = DateTime.now().year;
  String? _gender;
  String? _city;
  int? _pickedYear;
  List<String> _hobbies = [];
  final List<String> _hobbiesOptions = ['Gaming', 'Singing', 'Dancing', 'Reading','Playing','Cooking'];
  Map<String, dynamic> user = {};
  String searchValue = "";
  var selectedSort;
  bool isFilterCalled = false;
  bool isUserMale = true;
  int? userAge;

  @override
  void initState() {
    super.initState();
    // To Fetch the users from the local DB
    fetchUsers();
  }

  //Fetch From LocalDB
  Future<void> fetchUsers() async {
    await myDatabase.fetchUsersFromUsersTable();
    currentUsersList = myDatabase.usersList; // Initially, display all users
    setState(() {});
  }

  void searchUser(String searchData) {
    searchUsersList.clear(); // Clear previous search results
    if (searchData.isEmpty) {
      //For Local DB
      //region LocalDB
      currentUsersList = myDatabase.usersList; // If search is empty, show all users
      //endregion
      //For API
      currentUsersList = currentUsersList;
    } else {
      for (var element in myDatabase.usersList) {
        if (
        element[FULLNAME]
            .toString()
            .toLowerCase()
            .contains(searchData.toString().toLowerCase())||
            element[CITY]
                .toString()
                .toLowerCase()
                .contains(searchData.toString().toLowerCase()) ||
            element[GENDER]
                .toString()
                .toLowerCase()
                .contains(searchData.toString().toLowerCase())
        )
        {
          searchUsersList.add(element);
        }
      }
      currentUsersList = searchUsersList; // Update current list with search results
    }
    setState(() {}); // Rebuild the widget to reflect changes
  }

  void _filterUsers(String searchData) {
    searchUsersList.clear(); // Clear previous search results
    if (searchData.isEmpty) {
      currentUsersList = List.from(myDatabase.usersList); // If search is empty, show all users
    } else {
      for (var element in myDatabase.usersList) {
        if (element[FULLNAME]
            .toString()
            .toLowerCase()
            .contains(searchData.toString().toLowerCase())) {
          searchUsersList.add(element);
        }
      }
      currentUsersList = searchUsersList; // Update current list with search results
    }
  }

  void _sortUsers(String sortBy) {
    setState(() {
      // Create a mutable copy of the currentUsersList
      List<Map<String, dynamic>> mutableList = List.from(currentUsersList);

      if (sortBy == "Name") {
        mutableList.sort((a, b) =>
            a[FULLNAME].toLowerCase().compareTo(b[FULLNAME].toLowerCase()));
      } else if (sortBy == "NameDesc") {
        mutableList.sort((a, b) =>
            b[FULLNAME].toLowerCase().compareTo(a[FULLNAME].toLowerCase()));
      } else if (sortBy == "City") {
        mutableList.sort((a, b) =>
            a[CITY].toLowerCase().compareTo(b[CITY].toLowerCase()));
      } else if (sortBy == "CityDesc") {
        mutableList.sort((a, b) =>
            b[CITY].toLowerCase().compareTo(a[CITY].toLowerCase()));
      }

      // Update the currentUsersList with the sorted list
      currentUsersList = mutableList;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              // Header Row for User Profiles
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8, // Example: 90% of screen width
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0XFF800f2f).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.group_outlined,
                        size: 40,
                        color: Color(0XFF800f2f),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Profiles',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'List of Bondify Users', // Added user count here
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: SearchController,
                        onChanged: (value) {
                          searchValue = value;
                          searchUser(value);
                        },
                        decoration: InputDecoration(
                            hintText: "Search user",
                            hintStyle: TextStyle(color: Colors.black54),
                            prefixIcon: Icon(Icons.search, color: Color(0XFF590d22),size: 35,),
                            suffixIcon: IconButton(onPressed: (){
                              SearchController.clear();
                              searchUsersList.clear();
                              searchValue = "";
                              // For Local DB
                              currentUsersList = List.from(myDatabase.usersList);
                              setState(() {});
                            }, icon: Icon(Icons.cancel_outlined,color: Color(0XFF590d22),)),
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
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF800f2f).withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0XFFffccd5).withOpacity(0.4),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.sort, size: 32, color: Color(0XFF590d22),),
                        onPressed: () {
                          showMenu<String>(
                            context: context,
                            position: RelativeRect.fromLTRB(100, 100, 0, 0), // Adjust as needed
                            items: <PopupMenuEntry<String>>[
                              // Name Sorting
                              PopupMenuItem<String>(
                                value: "Name",
                                child: ListTile(
                                  leading: Icon(Icons.arrow_upward, color: Color(0XFF590d22)),
                                  title: Text('Name Ascending (A-Z)', style: TextStyle(color: Color(0XFF590d22))),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: "NameDesc",
                                child: ListTile(
                                  leading: Icon(Icons.arrow_downward, color: Color(0XFF590d22)),
                                  title: Text('Name Descending (Z-A)', style: TextStyle(color: Color(0XFF590d22))),
                                ),
                              ),
                            ],
                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Color(0XFF590d22))),
                            elevation: 8.0,
                            color:Color(0XFFfff0f3),
                          ).then((String? selectedSort) {
                            if (selectedSort != null) {
                              setState(() {
                                this.selectedSort = selectedSort;
                              });
                              _sortUsers(selectedSort);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(future:fetchUsers(), builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    child: currentUsersList.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Icon(Icons.search_off_outlined, size: 100, color: Color(0XFF590d22).withOpacity(0.4))),
                          Center(
                            child: Text(
                              'No profiles available.',
                              style: TextStyle(fontSize: 18, color: Color(0XFF590d22).withOpacity(0.4)),
                            ),
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      itemCount: currentUsersList.length,
                      itemBuilder: (context, index) {
                        var user = currentUsersList[index];
                        //Display Age
                        String dob = user[DOB];
                        int userBDateYear;

                        try {
                          if (dob.isNotEmpty) {
                            DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(dob); // Correct format
                            userBDateYear = parsedDate.year;
                            userAge = currentYear - userBDateYear;
                          } else {
                            userAge = 0; // Handle empty DOB
                          }
                        } catch (e) {
                          userAge = 0; // Handle parsing errors
                          print("Error parsing DOB: $dob. Exception: $e");
                        }
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0XFFfff0f3),
                                border:Border.all(color: Colors.black38),
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
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right:18),
                                              child: _buildUserAvatar(user[FULLNAME]),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    user[FULLNAME],
                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 2,top: 3),
                                                    child: Row(
                                                      children: [
                                                        //Display Age
                                                        Padding(
                                                          padding: const EdgeInsets.only(bottom: 3,right:1),
                                                          child: Icon(
                                                            Icons.cake_sharp,                                            size: 18,
                                                            color: Color(0XFF800f2f),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          userAge.toString(),
                                                          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                                        ),
                                                        Text(" | ",style: TextStyle(color: Colors.black,fontSize: 20),),
                                                        Icon(
                                                          isUserMale ? Icons.male : Icons.female,
                                                          size: 18,
                                                          color: Color(0XFF800f2f),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Expanded(
                                                          child: Text(
                                                            user[GENDER],
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                                          ),
                                                        ),
                                                        Text(" | ",style: TextStyle(color: Colors.black,fontSize: 20),),
                                                        Icon(
                                                          Icons.location_city,                                            size: 18,
                                                          color: Color(0XFF800f2f),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Expanded(
                                                          child: Text(
                                                            user[CITY],
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(thickness: 1,height: 18,color: Colors.black38,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5,top: 2),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _fullName.text = user[FULLNAME];
                                                  _phoneNumber.text = user[PHONE];
                                                  _email.text = user[EMAIL];
                                                  _dobController.text = user[DOB];
                                                  _gender = user[GENDER];
                                                  _city = user[CITY];
                                                  _pickedYear = DateFormat('dd-MM-yyyy').parse(user[DOB]).year;
                                                  _hobbies = (user[HOBBIES] as String).split(",").toList();

                                                  print("picked year from edit : $_pickedYear");

                                                  if (user[DOB] != null && user[DOB].isNotEmpty) {
                                                    DateTime dob = DateFormat('dd-MM-yyyy').parse(user[DOB]);
                                                    _pickedYear = dob.year;
                                                  } else {
                                                    _pickedYear = null; // Handle null or empty DOB
                                                  }

                                                  showModalBottomSheet(context: context,isScrollControlled: true,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                          builder: (BuildContext context, StateSetter setState) {
                                                            return DraggableScrollableSheet(
                                                              initialChildSize: 1, // Full height
                                                              minChildSize: 0.5, // Minimum height when dragged down
                                                              maxChildSize: 1, // Maximum height
                                                              builder: (_, controller) {
                                                                return SafeArea(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(12.0),
                                                                    child: Container(
                                                                      height: 400,
                                                                      child: SingleChildScrollView(
                                                                        scrollDirection: Axis.vertical,
                                                                        child: Form(
                                                                          key:_formKey,
                                                                          child: Column(
                                                                            children: [
                                                                              //Cancel Button
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 15),
                                                                                child: IconButton(onPressed: (){
                                                                                  Navigator.of(context).pop();
                                                                                }, icon: Icon(Icons.cancel_outlined),iconSize: 35,),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 20),
                                                                                child: Row(
                                                                                  children: [Icon(Icons.person_outline_rounded,size: 30,color: Color(0XFF800f2f),),
                                                                                    SizedBox(width: 10,),
                                                                                    Text('Person Details',style: TextStyle(fontSize: 20),)],
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10,),
                                                                              // Full Name Field
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                child: TextFormField(
                                                                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-z,A-Z]'))],
                                                                                  textCapitalization: TextCapitalization.words,
                                                                                  controller: _fullName,
                                                                                  keyboardType: TextInputType.text,
                                                                                  decoration: _inputDecoration(
                                                                                    labelText: 'Full Name',
                                                                                    prefixIcon: Icons.person_2_outlined,
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Please enter your full name';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              // Phone Number Field
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                child: TextFormField(
                                                                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                                                                                  controller: _phoneNumber,
                                                                                  keyboardType: TextInputType.phone,
                                                                                  decoration: _inputDecoration(
                                                                                    labelText: 'Phone Number',
                                                                                    prefixIcon: Icons.phone_outlined,
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Please enter your phone number';
                                                                                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                                                                      return 'Please enter a valid 10-digit phone number';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              // Email Field
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                child: TextFormField(
                                                                                  controller: _email,
                                                                                  keyboardType: TextInputType.emailAddress,
                                                                                  decoration: _inputDecoration(
                                                                                    labelText: 'Email Address',
                                                                                    prefixIcon: Icons.email_outlined,
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Please enter your email';
                                                                                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                                                                      return 'Please enter a valid email';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              // Date of Birth Field
                                                                              SizedBox(height: 20,),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(2.0),
                                                                                child: Row(
                                                                                  children: [Icon(Icons.cake_outlined,size: 30,color: Color(0XFF800f2f),),
                                                                                    SizedBox(width: 10,),
                                                                                    Text('Birth Date',style: TextStyle(fontSize: 20),)],
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10,),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                child: TextFormField(
                                                                                  readOnly: true,
                                                                                  controller: _dobController,
                                                                                  decoration: _inputDecoration(
                                                                                    labelText: 'Date of Birth',
                                                                                    prefixIcon: Icons.calendar_today_outlined,
                                                                                  ),
                                                                                  onTap: () async {
                                                                                    DateTime? pickedDate = await showDatePicker(
                                                                                      context: context,
                                                                                      initialDate: DateTime.now(),
                                                                                      firstDate: DateTime(1900),
                                                                                      lastDate: DateTime.now(),
                                                                                    );
                                                                                    if (pickedDate != null) {
                                                                                      setState(() {
                                                                                        _pickedYear = pickedDate.year;
                                                                                        print('Picked year from edit : ${_pickedYear}');
                                                                                        _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                                                                                      });
                                                                                    }
                                                                                  },
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Please select your date of birth';
                                                                                    }
                                                                                    if ((DateTime.now().year - _pickedYear!) < 18) {
                                                                                      return 'Age must be above 18 years!!';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 20,),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(2.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(Icons.wc_outlined, size: 30, color: Color(0XFF800f2f)),
                                                                                    SizedBox(width: 10),
                                                                                    Text('Gender', style: TextStyle(fontSize: 20)),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              // Gender Field
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                child: FormField<String>(
                                                                                  builder: (FormFieldState<String> state) {
                                                                                    return InputDecorator(
                                                                                      decoration: _inputDecoration(
                                                                                        labelText: 'Gender',
                                                                                        prefixIcon: Icons.wc_outlined,
                                                                                      ).copyWith(errorText: state.errorText),
                                                                                      child: Wrap(
                                                                                        spacing: 16,
                                                                                        runSpacing: 8,
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: [
                                                                                              Radio<String>(
                                                                                                value: 'Male',
                                                                                                groupValue: _gender,
                                                                                                onChanged: (value) {
                                                                                                  setState(() {
                                                                                                    _gender = value; // Update the gender value
                                                                                                    state.didChange(value); // Notify the FormField of the change
                                                                                                  });
                                                                                                },
                                                                                                activeColor: Color(0XFFa4133c),
                                                                                              ),
                                                                                              Text(
                                                                                                'Male',
                                                                                                style: TextStyle(fontSize: 16, color: Colors.black87),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: [
                                                                                              Radio<String>(
                                                                                                value: 'Female',
                                                                                                groupValue: _gender,
                                                                                                onChanged: (value) {
                                                                                                  setState(() {
                                                                                                    _gender = value; // Update the gender value
                                                                                                    state.didChange(value); // Notify the FormField of the change
                                                                                                  });
                                                                                                },
                                                                                                activeColor: Color(0XFFa4133c),
                                                                                              ),
                                                                                              Text(
                                                                                                'Female',
                                                                                                style: TextStyle(fontSize: 16, color: Colors.black87),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  validator: (value) {
                                                                                    if (_gender == null) {
                                                                                      return 'Please select your gender'; // Validation message
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10,),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(2.0),
                                                                                child: Row(
                                                                                  children: [Icon(Icons.location_city_outlined,size: 30,color: Color(0XFF800f2f),),
                                                                                    SizedBox(width: 10,),
                                                                                    Text('City',style: TextStyle(fontSize: 20),)],
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10,),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                child: DropdownButtonFormField<String>(
                                                                                  value: _city,
                                                                                  decoration: _inputDecoration(
                                                                                    labelText: 'City',
                                                                                  ),
                                                                                  icon: Icon(Icons.arrow_drop_down),
                                                                                  //city option array
                                                                                  items: [
                                                                                    "Ahmedabad",
                                                                                    "Surat",
                                                                                    "Vadodara",
                                                                                    "Rajkot",
                                                                                    "Bhavnagar",
                                                                                    "Jamnagar",
                                                                                    "Junagadh",
                                                                                    "Gandhinagar",
                                                                                    "Anand",
                                                                                    "Morbi",
                                                                                    "Nadiad",
                                                                                    "Mehsana",
                                                                                    "Bharuch",
                                                                                    "Navsari",
                                                                                    "Porbandar",
                                                                                    "Vapi",
                                                                                    "Valsad",
                                                                                    "Palanpur",
                                                                                    "Gondal",
                                                                                    "Godhra",
                                                                                    "Veraval",
                                                                                    "Patan",
                                                                                    "Kalol",
                                                                                    "Dahod",
                                                                                    "Botad",
                                                                                    "Amreli",
                                                                                    "Surendranagar",
                                                                                    "Himatnagar",
                                                                                    "Modasa",
                                                                                    "Mahesana",
                                                                                    "Dwarka",
                                                                                    "Mandvi",
                                                                                    "Ankleshwar",
                                                                                    "Deesa",
                                                                                    "Bhuj",
                                                                                    "Kadi",
                                                                                    "Visnagar",
                                                                                    "Dholka",
                                                                                    "Sanand",
                                                                                    "Wadhwan",
                                                                                    "Unjha",
                                                                                    "Halol",
                                                                                    "Chhota Udaipur",
                                                                                    "Lunawada",
                                                                                    "Savarkundla",
                                                                                    "Mahuva",
                                                                                    "Manavadar",
                                                                                    "Viramgam",
                                                                                    "Bodeli",
                                                                                    "Jetpur",
                                                                                    "Dhoraji",
                                                                                    "Jasdan",
                                                                                    "Khambhat",
                                                                                    "Keshod",
                                                                                    "Talaja",
                                                                                    "Mangrol",
                                                                                    "Bagasara",
                                                                                    "Umreth",
                                                                                    "Sihor",
                                                                                    "Petlad",
                                                                                    "Gadhada",
                                                                                    "Bhanvad",
                                                                                    "Vijapur",
                                                                                    "Radhanpur",
                                                                                    "Kutch",
                                                                                    "Kapadvanj",
                                                                                    "Tharad",
                                                                                    "Bayad",
                                                                                    "Idar",
                                                                                    "Mansa",
                                                                                    "Dabhoi",
                                                                                    "Karjan",
                                                                                    "Songadh",
                                                                                    "Bilkha",
                                                                                    "Okha",
                                                                                    "Jhalod",
                                                                                    "Mangrol (Junagadh)"
                                                                                  ]
                                                                                      .map(
                                                                                        (city) => DropdownMenuItem<String>(
                                                                                      value: city,
                                                                                      child: Text(
                                                                                        city,
                                                                                        style: TextStyle(color: Colors.black87),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                      .toList(),
                                                                                  onChanged: (value) {
                                                                                    _city = value;
                                                                                  },
                                                                                  validator: (value) {
                                                                                    if (value == null || value.isEmpty) {
                                                                                      return 'Please select your city';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              // Hobbies Field
                                                                              SizedBox(height: 20,),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(2.0),
                                                                                child: Row(
                                                                                  children: [Icon(Icons.interests,size: 30,color: Color(0XFF800f2f),),
                                                                                    SizedBox(width: 10,),
                                                                                    Text('Hobbies',style: TextStyle(fontSize: 20),)],
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 12,),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                                child: FormField(
                                                                                  builder: (FormFieldState state) {
                                                                                    return InputDecorator(
                                                                                      decoration: _inputDecoration(
                                                                                        labelText: 'Hobbies',
                                                                                      ).copyWith(errorText: state.errorText),
                                                                                      child: Wrap(
                                                                                        spacing: 28, // Horizontal spacing between buttons
                                                                                        runSpacing: 8, // Vertical spacing between buttons
                                                                                        children: _hobbiesOptions.map((hobby) {
                                                                                          return ElevatedButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                if (_hobbies.contains(hobby)) {
                                                                                                  _hobbies.remove(hobby);
                                                                                                  print(_hobbies);// Deselect if already selected
                                                                                                } else {
                                                                                                  _hobbies.add(hobby);
                                                                                                  print(_hobbies);// Select if not already selected
                                                                                                }
                                                                                              });
                                                                                              setState(() {
                                                                                                print('Hobbies updated!!');
                                                                                              });
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              backgroundColor: _hobbies.contains(hobby)
                                                                                                  ? Color(0XFFc9184a).withOpacity(0.7) // Selected state
                                                                                                  : Color(0XFF800f2f).withOpacity(0.2), // Unselected state
                                                                                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(20),
                                                                                              ),
                                                                                              elevation: 0,
                                                                                            ),
                                                                                            child: Text(
                                                                                              hobby,
                                                                                              style: TextStyle(
                                                                                                fontSize: 14,
                                                                                                color: _hobbies.contains(hobby)
                                                                                                    ? Colors.white // Text color for selected state
                                                                                                    : Colors.black87, // Text color for unselected state
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  validator: (value) {
                                                                                    if (_hobbies.isEmpty) {
                                                                                      return 'Please select at least one hobby';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 24),
                                                                              // Submit Button
                                                                              ElevatedButton(
                                                                                onPressed: () {
                                                                                  if (_formKey.currentState!.validate()) {
                                                                                    _formKey.currentState!.save();
                                                                                    setState(() {
                                                                                      Map<String,dynamic> updatedUser = Map.from(user);
                                                                                      int userId = user['id'];
                                                                                      updatedUser[FULLNAME] = _fullName.text;
                                                                                      updatedUser[PHONE] = _phoneNumber.text;
                                                                                      updatedUser[EMAIL] = _email.text;
                                                                                      updatedUser[DOB] = _dobController.text;
                                                                                      updatedUser[GENDER] = _gender;
                                                                                      updatedUser[CITY] = _city;
                                                                                      print("::: Updated Hobbies ${_hobbies.join(",")}");
                                                                                      updatedUser[HOBBIES] = _hobbies.join(",");
                                                                                      //region LocalDB
                                                                                      //Update method of Local DB
                                                                                      // myDatabase.updateUserInUsersTable(userId, updatedUser);
                                                                                      //endregion
                                                                                      //Mehtod Of API to edit the user
                                                                                      myDatabase.updateUserInUsersTable(userId, updatedUser);
                                                                                      fetchUsers();
                                                                                      _fullName.clear();
                                                                                      _phoneNumber.clear();
                                                                                      _email.clear();
                                                                                      _dobController.clear();
                                                                                      _religion.clear();
                                                                                      _gender = null;
                                                                                      _city = null;
                                                                                      _hobbies.clear();
                                                                                      Navigator.of(context).pop();
                                                                                    });
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(content: Text('Profile edited successfully!',selectionColor: Colors.red,)),
                                                                                    );
                                                                                    fetchUsers();
                                                                                  }
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: Color(0XFFa4133c),
                                                                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(12),
                                                                                  ),
                                                                                  elevation: 3,
                                                                                ),
                                                                                child: Text(
                                                                                  'Save Profile',
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 18,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 24),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                      );
                                                    },);
                                                  ;
                                                },
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Color(0XFF800f2f).withOpacity(0.1),
                                                      border: Border.all(style: BorderStyle.solid),
                                                      borderRadius:BorderRadius.circular(10)
                                                  ),
                                                  width: 90,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                          padding: const EdgeInsets.only(left: 8),
                                                          child: Text('Edit',style: TextStyle(fontSize: 16,),)
                                                      ),
                                                      SizedBox(width: 12),
                                                      Icon(Icons.edit_note_rounded, color: Colors.brown[700], size: 30,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 24,),
                                              //Delete
                                              InkWell(
                                                onTap: () async {
                                                  //region LocalDB
                                                  // Local DB
                                                  // int userId = user['id'];
                                                  //region LocalDB
                                                  int userId = user['id'];
                                                  return showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false, // user must tap button!
                                                    builder: (BuildContext context) {
                                                      return SizedBox(
                                                        width: 600,
                                                        child: AlertDialog(
                                                          backgroundColor: Color(0XFFfff0f3),
                                                          title: Row(
                                                            children: [
                                                              Icon(Icons.delete,color: Color(0XFFa4133c),size: 35,),
                                                              SizedBox(width: 10,),
                                                              const Text('Are You Sure ?',style: TextStyle(color: Color(0XFFc9184a)),),
                                                            ],
                                                          ),
                                                          content: const SingleChildScrollView(
                                                            child: ListBody(
                                                              children: <Widget>[
                                                                Text('You are going to remove the User!!',style: TextStyle(color: Colors.black54),),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text('Yes, Remove user!',style: TextStyle(color: Color(0XFFa4133c)),),
                                                              onPressed: () {
                                                                //region LocalDB
                                                                //Delete From LocalDB
                                                                // myDatabase.deleteUserFromUsersTable(userId);
                                                                //endregion
                                                                myDatabase.deleteUserFromUsersTable(userId);
                                                                fetchUsers();
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                            TextButton(onPressed: (){
                                                              Navigator.of(context).pop();
                                                            }, child: Text('Cancel',style: TextStyle(color: Colors.black),))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Color(0XFF800f2f).withOpacity(0.1),
                                                      border: Border.all(style: BorderStyle.solid),
                                                      borderRadius:BorderRadius.circular(10)
                                                  ),
                                                  width: 95,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10),
                                                        child: Text('Delete'),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.delete, color: Colors.brown[700], size: 26),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width:24),
                                              //Favorite
                                              IconButton(
                                                visualDensity : VisualDensity.compact,
                                                onPressed: () async {
                                                  int userId = user['id'];
                                                  int newFavStatus = (user[ISUSERFAV] == 1) ? 0 : 1;
                                                  await myDatabase.makeUserFav(userId, newFavStatus);
                                                  showDialog(context: context, builder: (context) {
                                                    return Center(child: Expanded(child: CircularProgressIndicator(color: Color(0XFF590d22),)));
                                                  },);
                                                  await myDatabase.updateUserInUsersTable(userId,{ISUSERFAV : newFavStatus});
                                                  await fetchUsers();
                                                  Navigator.of(context).pop();
                                                  setState(() {

                                                  });
                                                },
                                                icon: (user[ISUSERFAV] == true)
                                                    ? Icon(Icons.favorite, color: Colors.redAccent, size: 26,)
                                                    : Icon(Icons.favorite_outline_rounded, color:  Colors.brown[700], size: 28,),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            _showFullDetailsBottomSheet(context, user);
                          },
                        );
                      },
                    ),
                  );
                }
                else{
                  return Expanded(child: Center(child: CircularProgressIndicator(color: Color(0XFF590d22),)));
                }
              },)
            ],
          ),
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

  // Function to show the bottom sheet for full details (updated)
  void _showFullDetailsBottomSheet(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0XFFfff0f3).withOpacity(0.98), // Set background to white
      isScrollControlled: true, // Make the bottom sheet scrollable
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) {
        return SingleChildScrollView( // Make the content scrollable
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
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

  InputDecoration _inputDecoration({labelText, prefixIcon}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black54),
      prefixIcon: prefixIcon != null ?
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color:Color(0XFFffb3c1).withOpacity(0.3),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(prefixIcon, color: Color(0XFF590d22)),
          ),
        ),
      ) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0XFF590d22), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0XFF590d22), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0XFF590d22), width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
    );
  }
}