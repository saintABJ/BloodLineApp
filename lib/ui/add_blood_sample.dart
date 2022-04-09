import 'package:flutter/material.dart';
import 'package:flutter_polygon_clipper/flutter_polygon_clipper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grazac_blood_line_app/model/user_model.dart';
import 'package:grazac_blood_line_app/ui/background.dart';
import 'package:grazac_blood_line_app/ui/donors_list.dart';
import 'package:grazac_blood_line_app/resources/services.dart';
import 'package:grazac_blood_line_app/ui/home_screen.dart';
import 'package:grazac_blood_line_app/ui/profile_screen.dart';
import 'package:grazac_blood_line_app/ui/widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignUp> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _age = TextEditingController();
  final _phoneNumber = TextEditingController();

  String? selectedGender, selectedRhesusFactor, selectedBloodGroup;
  // final _scaffoldkey = GlobalKey<ScaffoldState>();
  String signupText = "Become A" "\nLife Saver Today!";
  bool index = true;
  bool isLoading = false;
  bool hiddenText = true;

  static const bloodGroups = <String>['A+', 'A-', 'B+', 'B-', 'O+', 'O-'];
  static const genders = <String>['Male', 'Female'];
  static const rhesusFactors = <String>['Positive', 'Negative'];

  final List<DropdownMenuItem<String>> _bloodgroups = bloodGroups
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: const TextStyle(
                color: Colors.red,
              )),
        ),
      )
      .toList();

  final List<DropdownMenuItem<String>> _gender = genders
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: const TextStyle(
                color: Colors.red,
              )),
        ),
      )
      .toList();

  final List<DropdownMenuItem<String>> _rhesusFactor = rhesusFactors
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: const TextStyle(
                color: Colors.red,
              )),
        ),
      )
      .toList();

  void _addUser() async {
    if (_formkey.currentState?.validate() ?? false) {
      _formkey.currentState?.save();
      UserModel user = UserModel(
          userName: _userName.text,
          age: _age.text,
          bloodGroup: selectedBloodGroup!,
          gender: selectedGender!,
          phoneNumber: _phoneNumber.text,
          rhesusFactor: selectedRhesusFactor!);
      setState(() {
        isLoading = true;
      });
      var response = await BloodSampleServices.createPost(user);
      var getList = await BloodSampleServices.getUserModel();
      

      // if (getUser == "A Blood Sample shown successfully") {
      //   Fluttertoast.showToast(
      //       msg: response!,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white,
      //       fontSize: 16.0);    
      //    Future.delayed(const Duration(seconds: 5), () {
      //     Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => ProfileScreen(donors: getUser.)));
      //   });
      // } else {
      //   Fluttertoast.showToast(
      //       msg: response!,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // }
      setState(() {
        isLoading = false;
      });
      if (response == "Blood Sample created successfully") {
        Fluttertoast.showToast(
            msg: response!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
            Future.delayed(const Duration(seconds: 5), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DonorsList(
                  donors: getList.item1!,
                      )));
        });
      } else {
        Fluttertoast.showToast(
            msg: response!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff44130f),
      // key: _scaffoldkey,
      body: BaseScreen(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: const <Widget>[

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      signupText,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                buildSignupForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildSignupForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            textCapitalization: TextCapitalization.words,
            inputType: TextInputType.emailAddress,
            controller: _userName,
            onSaved: (value) {},
            label: "Username",
            hint: "Ex: Ayo Test",
            onValidate: (value) {
              if (value.isEmpty) return 'This field can\'t be empty';
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            inputType: TextInputType.number,
            controller: _age,
            onSaved: (value) {},
            hint: "Age",
            onValidate: (value) {
              if (value.isEmpty) return 'This field can\'t be empty';
            },
            label: "Age",
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            inputType: TextInputType.number,
            controller: _phoneNumber,
            onSaved: (value) {},
            onValidate: (value) {
              if (value.length != 10) {
                return 'Phone Number must be 10 digits';
              } else if (value.isEmpty) {
                return 'This field can\'t be empty';
              }
            },
            label: 'Phone Number',
            hint: 'Ex: 1234567890',
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 1),
              ),
            ),
            child: DropdownButtonFormField(
              value: selectedGender,
              hint: const Text(
                'Gender',
                style: TextStyle(color: Colors.grey),
              ),
              items: _gender,
              onChanged: (String? genders) {
                setState(() {
                  selectedGender = genders!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
            ),
            child: DropdownButtonFormField(
              value: selectedRhesusFactor,
              hint: const Text(
                'Rhesus Factor',
                style: TextStyle(color: Colors.grey),
              ),
              items: _rhesusFactor,
              onChanged: (String? newvalue) {
                setState(() {
                  selectedRhesusFactor = newvalue!;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
            child: DropdownButtonFormField(
                value: selectedBloodGroup,
                hint: const Text(
                  'Blood Group',
                  style: TextStyle(color: Colors.grey),
                ),
                items: _bloodgroups,
                onChanged: (String? newvalue) {
                  setState(() {
                    selectedBloodGroup = newvalue!;
                  });
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 90,
                child: FlutterClipPolygon(
                  sides: 6,
                  rotate: 120,
                  borderRadius: 9.0,
                  child: Container(
                    color: Colors.red,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.yellow,
                              ),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            onPressed: _addUser),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showErrorDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: const Text('Enter the fields',
                  style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                FlatButton(
                  child: const Text('ok'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              title: const Text('Error'));
        });
  }
}
