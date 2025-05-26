import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'DB.dart';
import 'String_Utils.dart';
import 'display_all_profiles.dart';
import 'display_fav_profiles.dart';

class AddProfile extends StatefulWidget {
  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  //region LocalDB
  //For LocalDB
  DB myDatabase = DB();
  //endregion

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _religion = TextEditingController();
  String? _gender;
  String? _city;
  int? _pickedYear;
  List<String> _hobbies = [];
  final List<String> _hobbiesOptions = ['Gaming', 'Singing', 'Dancing', 'Reading','Playing','Cooking'];
  Map<String, dynamic> user = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfiles(),));
          },
              icon: Icon(Icons.list_alt_outlined)
          ),
          IconButton(
              onPressed: () => MaterialPageRoute(builder: (context) => DisplayFavUserProfiles(),),
              icon: Icon(Icons.favorite_border_rounded))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Row Add Profile
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0XFF800f2f).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_add,
                            size: 40,
                            color: Color(0XFF800f2f),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Profile',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Enter Information below',
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
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
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
                      children: [Icon(Icons.cake_outlined,size: 30,color: Color(0XFF800f2f),),
                        SizedBox(width: 10,),
                        Text('Gender',style: TextStyle(fontSize: 20),)],
                    ),
                  ),
                  SizedBox(height: 10,),
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
                                        _gender = value;
                                        state.didChange(value);
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
                                        _gender = value;
                                        state.didChange(value);
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
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                  ),
                  //religion field
                  // Religion Field
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //   child: TextFormField(
                  //     controller: _religion,
                  //     maxLength: 30,
                  //     decoration: _inputDecoration(
                  //       labelText: 'Religion',
                  //       prefixIcon: LineIcons.church,
                  //     ),
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Please enter your religion';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  // City Dropdown Field
                  SizedBox(height: 20,),
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
                      decoration: _inputDecoration(
                        labelText: 'City',
                      ),
                      icon: Icon(Icons.arrow_drop_down),
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
                            spacing: 19, // Horizontal spacing between buttons
                            runSpacing: 8, // Vertical spacing between buttons
                            children: _hobbiesOptions.map((hobby) {
                              return ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (_hobbies.contains(hobby)) {
                                      _hobbies.remove(hobby); // Deselect if already selected
                                    } else {
                                      _hobbies.add(hobby); // Select if not already selected
                                    }
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
                          user[FULLNAME] = _fullName.text;
                          user[PHONE] = _phoneNumber.text;
                          user[EMAIL] = _email.text;
                          user[DOB] = _dobController.text;
                          user[GENDER] = _gender;
                          user[CITY] = _city;
                          user[HOBBIES] = _hobbies.join(",");
                          //DB Method
                          // myDatabase.addUserInUsersTable(user);

                          //API
                          myDatabase.addUserInUsersTable(user);
                          // Clear the form fields after submission.
                          _fullName.clear();
                          _phoneNumber.clear();
                          _email.clear();
                          _dobController.clear();
                          _religion.clear();
                          _gender = null;
                          _city = null;
                          _hobbies.clear();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Profile submitted successfully!')),
                        );
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
                      'Submit Profile',
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