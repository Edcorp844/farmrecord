class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String location;
  final String phone;
  final String gender;
  final String farmName;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.location,
    required this.phone,
    required this.gender,
    required this.farmName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'location': location,
      'phone': phone,
      'gender': gender,
      'farmName': farmName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      location: map['location'],
      phone: map['phone'],
      gender: map['gender'],
      farmName: map['farmName'],
    );
  }
}

class Catttle {
  int? id; // Unique identifier for the cattle record
  String cattleId; // ID of the cattle
  String type; // Type of the cattle (e.g., breed)
  String purpose; // Purpose of the cattle (e.g., beef or milk)

  // Constructor
  Catttle({
    this.id,
    required this.cattleId,
    required this.type,
    required this.purpose,
  });

  // Method to convert a Cattle object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cattleId': cattleId,
      'type': type,
      'purpose': purpose,
    };
  }

  // Factory method to create a Cattle object from a map
  factory Catttle.fromMap(Map<String, dynamic> map) {
    return Catttle(
      id: map['id'],
      cattleId: map['cattleId'],
      type: map['type'],
      purpose: map['purpose'],
    );
  }
}

class Diseased {
  int? id;
  DateTime date;
  String cattleId;
  String disease;
  String medication;
  int times;
  int? userId; // Assuming each diseased cattle belongs to a user

  Diseased({
    this.id,
    required this.date,
    required this.cattleId,
    required this.disease,
    required this.medication,
    required this.times,
    required this.userId,
  });

  // Convert to map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'cattleId': cattleId,
      'disease': disease,
      'medication': medication,
      'times': times,
      'userId': userId,
    };
  }

  // Create Diseased instance from map
  factory Diseased.fromMap(Map<String, dynamic> map) {
    return Diseased(
      id: map['id'],
      date: DateTime.parse(map['date']),
      cattleId: map['cattleId'],
      disease: map['disease'],
      medication: map['medication'],
      times: map['times'],
      userId: map['userId'],
    );
  }
}

class Milk {
  final int? id;
  final String time;
  final int liters;
  final DateTime date;
  final String cowID;
  final int userId;

  // Constructor with non-null assertions for required fields
  Milk({
    required this.time,
    required this.liters,
    required this.date,
    required this.cowID,
    required this.userId,
    this.id, // Optional id for existing records
  })  : assert(time.isNotEmpty), // Assert time is not empty
        assert(liters >= 0); // Assert liters are non-negative

  // Factory constructor for creating Milk objects from maps
  factory Milk.fromMap(Map<String, dynamic> map) {
    return Milk(
      time: map['time'] as String,
      liters: map['liters'] as int,
      date: DateTime.parse(map['date']),
      cowID: map['cowId'] as String,
      userId: map['userId'] as int,
      id: map['id'] as int?,
    );
  }

  // Method to convert Milk object to a map for database insertion
  Map<String, dynamic> toMap() => {
        'time': time,
        'liters': liters,
        'date': date.toIso8601String(),
        'cowId': cowID,
        'userId': userId,
        if (id != null) 'id': id, // Include id only if it exists
      };
}

class Feeding {
  final int? id;
  final int sacks;
  final DateTime date;
  final int userId;

  Feeding({
    this.id,
    required this.sacks,
    required this.date,
    required this.userId,
  });

  factory Feeding.fromJson(Map<String, dynamic> json) {
    return Feeding(
      id: json['id'],
      sacks: json['sacks'],
      date: DateTime.parse(json['date']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sacks': sacks,
      'date': date.toIso8601String(),
      'userId': userId,
    };
  }
}

class Expense {
  final int? id;

  final String item;
  final int amount;
  final DateTime date;
  final int userId;

  Expense({
    this.id,
    required this.item,
    required this.amount,
    required this.date,
    required this.userId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      item: json['item'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item,
      'amount': amount,
      'date': date.toIso8601String(),
      'userId': userId,
    };
  }
}
