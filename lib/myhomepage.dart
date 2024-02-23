import 'package:flutter/material.dart';

class Myform extends StatefulWidget {
  const Myform({super.key});

  @override
  State<Myform> createState() => _MyformState();
}

List<String> reusableStrings = [
  'Name',
  'Email',
  'Password',
  'Batch',
  'PhoneNumber',
];

class _MyformState extends State<Myform> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Colors.green[200],
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 28.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/p1.jpg'),
                ),
              ),
              Form(
                key: _formKey,
                // ignore: prefer_const_constructors
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      CustomField(
                        controller: _nameController,
                        hint: reusableStrings[0],
                        icon: const Icon(Icons.person),
                        isPasswordField: false,
                        focusNode: myFocusNode,
                      ),
                      CustomField(
                        controller: _emailController,
                        hint: reusableStrings[1],
                        icon: const Icon(Icons.email),
                        isPasswordField: false,
                      ),
                      CustomField(
                        controller: _passwordController,
                        hint: reusableStrings[2],
                        icon: const Icon(Icons.lock),
                        isPasswordField: true,
                      ),
                      CustomField(
                        controller: _batchController,
                        hint: reusableStrings[3],
                        icon: const Icon(Icons.batch_prediction),
                        isPasswordField: false,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 70,
                              child: CustomField(
                                hint: '+77',
                                controller: _phoneController,
                                isPasswordField: false,
                              )),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: CustomField(
                              hint: reusableStrings[4],
                              controller: _numberController,
                              isPasswordField: false,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, proceed
                                // You can process the form data here
                                String name = _nameController.text;
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                String batch = _batchController.text;
                                // For demonstration, print the data
                                //print('$name');
                                //print('$email');
                                //print('$password');
                                //print('$batch');
                                // }
                                showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                        content: Text(
                                            'Wecome ${_nameController.text}'));
                                  },
                                );
                              }
                            },
                            child: const Text('Submit'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green)),
                              onPressed: () {
                                _formKey.currentState?.reset();
                                myFocusNode.requestFocus();
                              },
                              child: const Text('reset'))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomField extends StatefulWidget {
  CustomField(
      {super.key,
      required this.hint,
      this.icon,
      required this.controller,
      required this.isPasswordField,
      this.focusNode});

  final String hint;
  final Icon? icon;
  final TextEditingController controller;
  bool isPasswordField = true;
  late FocusNode? focusNode;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode = FocusNode();
  }

  @override
  void dispose() {
    widget.focusNode = FocusNode();
    super.dispose();
  }

  String errorTextValue = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            //Text(widget.hint),
            TextFormField(
              // autofocus: true,
              focusNode: widget.focusNode,
              controller: widget.controller,
              obscureText: widget.isPasswordField == true,
              onChanged: (value) {
                setState(() {
                  if (value.contains(' ')) {
                    errorTextValue = "don 't use blank spaces ";
                  } else {
                    errorTextValue = '';
                  }
                });
              },
              decoration: InputDecoration(
                  prefixIcon: widget.icon,
                  hintText: widget.hint,
                  suffix: widget.isPasswordField == true
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.isPasswordField = !widget.isPasswordField;
                            });
                          },
                          child: Icon(
                            widget.isPasswordField
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye,
                          ))
                      : const SizedBox(),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent)),
                  errorText: errorTextValue.isEmpty ? null : errorTextValue),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your ${widget.hint}';
                }
                return null;
              },
            ),
          ],
        ));
  }
}
