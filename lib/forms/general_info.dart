import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medipal/forms/input_template.dart';
import 'package:medipal/objects/patient.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GeneralInfoForm extends StatefulWidget {
  final Patient patient;
  final GlobalKey<FormState> formKey;

  const GeneralInfoForm({
    super.key,
    required this.patient,
    required this.formKey,
  });

  @override
  GeneralInfoFormState createState() {
    return GeneralInfoFormState();
  }
}

class GeneralInfoFormState extends State<GeneralInfoForm> {
  // List choices
  List<int> years =
      List.generate(100, (int index) => DateTime.now().year - 100 + index);
  List<int> months = List.generate(12, (int index) => index + 1);
  List<int> days = List.generate(31, (int index) => index + 1);
  List<String> bloodGroups = ['A', 'B', 'AB', 'O'];
  List<String> rhFactors = ['+', '-'];
  List<String> phoneTypes = ['home', 'work', 'mobile'];
  File? imageFile;
  double uploadProgress = 0;
  String? uploadStatus;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path); // Store the actual picked image path
      });
    }
  }

  Future<void> uploadImage() async {
    if (imageFile == null) return;

    final metadata = SettableMetadata(contentType: "image/jpeg");
    final storageRef = FirebaseStorage.instance.ref();
    final uploadTask = storageRef
        .child("images/${DateTime.now()}.jpg")
        .putFile(imageFile!, metadata);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      setState(() {
        uploadProgress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        uploadStatus = taskSnapshot.state == TaskState.running
            ? "Uploading..."
            : "Upload complete";
      });

      if (taskSnapshot.state == TaskState.success) {
        // Handle successful upload (e.g., navigate to next form)
        print("Upload successful!");
        // You can potentially navigate to the next form here
      } else if (taskSnapshot.state == TaskState.error) {
        // Handle unsuccessful upload
        print("Upload failed!");
        // Display error message to the user
      }
    });
  }

  // build
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if (imageFile != null)
                    Image.file(imageFile!, height: 200, width: 200),
                  Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: pickImage,
                        child: Text('Select Image'),
                      ),
                      ElevatedButton(
                        onPressed: uploadImage,
                        child: Text('Upload Image'),
                      ),
                      if (uploadStatus != null)
                        Text(
                          uploadStatus!,
                          style: TextStyle(fontSize: 16),
                        ),
                    ],
                  ),
                ],
              ),
              buildTextFormField(
                labelText: 'First Name',
                value: widget.patient.firstName,
                onChanged: (value) {
                  setState(() {
                    widget.patient.firstName = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                labelText: 'Middle Name',
                value: widget.patient.middleName,
                onChanged: (value) {
                  setState(() {
                    widget.patient.middleName = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                labelText: 'Last Name',
                value: widget.patient.lastName,
                onChanged: (value) {
                  setState(() {
                    widget.patient.lastName = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                labelText: 'Location',
                value: widget.patient.location,
                onChanged: (value) {
                  setState(() {
                    widget.patient.location = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                labelText: 'Sex',
                value: widget.patient.sex,
                onChanged: (value) {
                  setState(() {
                    widget.patient.sex = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const Text('Date of Birth'),
              
              Row(
                children: [
                  // Dropdown for Year
                  SizedBox(
                    width: 100,
                    child: buildDropdownFormField<int>(
                      value: widget.patient.dob?.year,
                      onChanged: (int? value) {
                        setState(() {
                          widget.patient.dob = DateTime(
                              value ?? 0,
                              widget.patient.dob?.month ?? 1,
                              widget.patient.dob?.day ?? 1);
                        });
                      },
                      items: years,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a year';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Dropdown for Month
                  SizedBox(
                    width: 50,
                    child: buildDropdownFormField<int>(
                      value: widget.patient.dob?.month,
                      onChanged: (int? value) {
                        setState(() {
                          widget.patient.dob = DateTime(
                              widget.patient.dob?.year ?? DateTime.now().year,
                              value ?? 1,
                              widget.patient.dob?.day ?? 1);
                        });
                      },
                      items: months,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a month';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Dropdown for Day
                  SizedBox(
                    width: 50,
                    child: buildDropdownFormField<int>(
                      value: widget.patient.dob?.day,
                      onChanged: (int? value) {
                        setState(() {
                          widget.patient.dob = DateTime(
                              widget.patient.dob?.year ?? DateTime.now().year,
                              widget.patient.dob?.month ?? 1,
                              value ?? 1);
                        });
                      },
                      items: days,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a day';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Blood Group'),
                  SizedBox(
                    width: 50,
                    child: buildDropdownFormField<String>(
                      value: widget.patient.bloodGroup,
                      onChanged: (String? value) {
                        setState(() {
                          widget.patient.bloodGroup = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a blood group';
                        }
                        return null;
                      },
                      items: bloodGroups,
                    ),
                  ),
                  Text('RH Factor'),
                  SizedBox(
                    width: 50,
                    child: buildDropdownFormField<String>(
                      value: widget.patient.rhFactor,
                      onChanged: (String? value) {
                        setState(() {
                          widget.patient.rhFactor = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select an RH factor';
                        }
                        return null;
                      },
                      items: rhFactors,
                    ),
                  ),
                ],
              ),
              buildTextFormField(
                labelText: 'Marital Status',
                value: widget.patient.maritalStatus,
                onChanged: (value) {
                  setState(() {
                    widget.patient.maritalStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                labelText: 'E-mail',
                value: widget.patient.email,
                onChanged: (value) {
                  setState(() {
                    widget.patient.email = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Text('Phone'),
              Column(
                children: [
                  ...List.generate(widget.patient.phone?.length ?? 0, (index) {
                    PhoneData contact = widget.patient.phone![index];
                    return Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: buildDropdownFormField<String>(
                            value: contact.type,
                            onChanged: (String? value) {
                              setState(() {
                                contact.type = value;
                              });
                            },
                            items: phoneTypes,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a phone type';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: buildTextFormField(
                            labelText: 'Phone Number ${index + 1}',
                            value: contact.phoneNumber?.toString(),
                            onChanged: (value) {
                              contact.phoneNumber = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSuffixIconTap: index == 0
                                ? null
                                : () =>
                                    _removeField(widget.patient.phone, index),
                          ),
                        ),
                      ],
                    );
                  }),
                  //Add more button
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        _addField(widget.patient.phone, PhoneData());
                      },
                      child: Text("Add More"),
                    ),
                  ),
                ],
              ),
              Text('Emergancy Contacts'),
              Column(
                children: [
                  ...List.generate(widget.patient.emergency?.length ?? 0,
                      (index) {
                    EmergancyData contact = widget.patient.emergency![index];
                    return Row(
                      children: [
                        Expanded(
                          child: buildTextFormField(
                            labelText: 'Name ${index + 1}',
                            value: contact.name?.toString(),
                            onChanged: (value) {
                              contact.name = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: 100,
                          child: buildDropdownFormField<String>(
                            value: contact.type,
                            onChanged: (String? value) {
                              setState(() {
                                contact.type = value;
                              });
                            },
                            items: phoneTypes,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a phone type';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: buildTextFormField(
                            labelText: 'Phone Number ${index + 1}',
                            value: contact.phoneNumber?.toString(),
                            onChanged: (value) {
                              contact.phoneNumber = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSuffixIconTap: index == 0
                                ? null
                                : () => _removeField(
                                    widget.patient.emergency, index),
                          ),
                        ),
                      ],
                    );
                  }),
                  //Add more button
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        _addField(widget.patient.emergency, EmergancyData());
                      },
                      child: Text("Add More"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _addField(List<dynamic>? list, dynamic value) {
    list!.add(value);
    setState(() {});
  }

  _removeField(List<dynamic>? list, int index) {
    if (list != null && index < list.length) {
      list.removeAt(index);
      setState(() {});
    }
  }
}

String? validateDropDown(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please select an option';
  }
  return null;
}
