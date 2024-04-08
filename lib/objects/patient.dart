import 'package:firebase_database/firebase_database.dart';

class Patient {
  // VARTIABLES
  // personal info
  // name
  String? firstName;
  String? middleName;
  String? lastName;
  // date of birth
  DateTime? dob;
  // blood
  String? bloodGroup;
  String? rhFactor;
  String? maritalStatus;
  // contact
  String? email;
  List<PhoneData>? phone = [PhoneData()];
  List<EmergancyData>? emergency = [EmergancyData()];
  // illnesses/allergies
  List<String>? currIllness = [];
  List<String>? prevIllness = [];
  List<String>? allergies = [];
  // medications
  List<String>? currMedications = [];
  List<String>? prevMedications = [];

  // CONSTRUCTOR
  Patient(
      /* {
    this.firstName,
    this.middleName,
    this.lastName,
    this.dob,
    this.bloodGroup,
    this.rhFactor,
    this.maritalStatus,
    this.email,
    this.phone,
    this.emergency,
    this.currIllness,
    this.prevIllness,
    this.allergies,
    this.currMedications,
    this.prevMedications,
  } */
      );
  // convert patient data to json map
  // used for input to database
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'dob': dob?.toIso8601String(),
      'bloodGroup': bloodGroup,
      'rhFactor': rhFactor,
      'maritalStatus': maritalStatus,
      'email': email,
      'phone': phone?.map((e) => e.toJson()).toList(),
      'emergancy': emergency?.map((e) => e.toJson()).toList(),
      'illnessCurr': currIllness ?? [],
      'illnessPrev': prevIllness ?? [],
      'allergies': allergies ?? [],
      'medicationsCurr': currMedications ?? [],
      'medicationsPrev': prevMedications ?? [],
    };
  }

  factory Patient.fromSnapshot(DataSnapshot snapshot) {
    if (snapshot.exists) {
      Map<dynamic, dynamic>? value = snapshot.value as Map<dynamic, dynamic>;
      return Patient.fromMap(value.cast<String, dynamic>());
    }
    throw const FormatException('snapshot does not exist');
  }

  factory Patient.fromMap(Map<String, dynamic> jsonMap) {
    Patient p = Patient();
    p.firstName = jsonMap['firstName'];
    p.middleName = jsonMap['middleName'];
    p.lastName = jsonMap['lastName'];
    p.dob = jsonMap['dob'] != null ? DateTime.parse(jsonMap['dob']) : null;
    p.bloodGroup = jsonMap['bloodGroup'];
    p.rhFactor = jsonMap['rhFactor'];
    p.email = jsonMap['email'];
    // Check if phone list is not null before mapping
    if (jsonMap['phone'] != null && jsonMap['phone'] is List<dynamic>) {
      p.phone = (jsonMap["phone"] as List<dynamic>)
          .map((phoneMap) => PhoneData(
                phoneNumber: phoneMap["phoneNumber"] as String,
                type: phoneMap["type"] as String,
              ))
          .toList();
    }
    // Check if emergency list is not null before mapping
    if (jsonMap['emergency'] != null && jsonMap['emergency'] is List<dynamic>) {
      p.emergency = (jsonMap["emergency"] as List<dynamic>)
          .map((emergencyMap) => EmergancyData(
                name: emergencyMap["name"] as String,
                phoneNumber: emergencyMap["phoneNumber"] as String,
                type: emergencyMap["type"] as String,
              ))
          .toList();
    }
    List<dynamic>? allergiesList = jsonMap['allergies'];
    if (allergiesList is List<dynamic>) {
      p.allergies = allergiesList.cast<String>();
    }
    List<dynamic>? currList = jsonMap['illnessCurr'];
    if (currList is List<dynamic>) {
      p.currIllness = currList.cast<String>();
    }
    List<dynamic>? prevList = jsonMap['illnessPrev'];
    if (prevList is List<dynamic>) {
      p.prevIllness = prevList.cast<String>();
    }
    List<dynamic>? currMed = jsonMap['medicationsCurr'];
    if (currMed is List<dynamic>) {
      p.currMedications = currMed.cast<String>();
    }
    List<dynamic>? prevMed = jsonMap['medicationsPrev'];
    if (prevMed is List<dynamic>) {
      p.prevMedications = prevMed.cast<String>();
    }
    return p;
  }

  @override
  String toString() {
    String str = '';
    str += "firstName: $firstName\n";
    str += "middleName: $middleName\n";
    str += "lastName: $lastName\n";
    str += "dob: $dob\n";
    str += "bloodGroup: $bloodGroup\n";
    str += "rhFactor: $rhFactor\n";
    str += "email: $email\n";
    str += "phone: ${phone.toString()}\n";
    str += "allergies: $allergies\n";
    str += "currIllness: $currIllness\n";
    str += "prevIllness: $prevIllness\n";
    return str;
  }
}

class PhoneData {
  String? type;
  String? phoneNumber;

  PhoneData({
    this.phoneNumber,
    this.type,
  });

  // convert phone data to a map
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  String toString() {
    String str = '';
    str += "type: $type ";
    str += "phoneNumber: $phoneNumber\n";
    return str;
  }
}

class EmergancyData extends PhoneData {
  String? name;

  EmergancyData({
    this.name,
    super.type,
    super.phoneNumber,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {'name': name};
    map.addAll(super.toJson());
    return map;
  }

  factory EmergancyData.fromJson(Map<String, dynamic> json) {
    return EmergancyData(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      type: json['type'],
    );
  }

  @override
  String toString() {
    String str = '';
    str += "type: $name ";
    str += super.toString();
    return str;
  }
}
