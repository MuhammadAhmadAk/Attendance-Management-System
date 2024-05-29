import 'package:flutter/material.dart';

// Define a class representing a student
class Student {
  final String rollNo;
  final String name;
  final String department;
  final int semester;

  Student({
    required this.rollNo,
    required this.name,
    required this.department,
    required this.semester,
  });
}

class FullRecord extends StatelessWidget {
  const FullRecord({
    Key? key,
    required this.dapartment,
    required this.semester,
  }) : super(key: key);
  final String dapartment;
  final String semester;
  // Define static list of students
  static final List<Student> students = [
    Student(
      rollNo: '001',
      name: 'John Doe',
      department: 'Computer Science',
      semester: 3,
    ),
    Student(
      rollNo: '002',
      name: 'Jane Smith',
      department: 'Electrical Engineering',
      semester: 2,
    ),
    Student(
      rollNo: '003',
      name: 'Alice Johnson',
      department: 'Mechanical Engineering',
      semester: 4,
    ),
    Student(
      rollNo: '004',
      name: 'Bob Brown',
      department: 'Civil Engineering',
      semester: 3,
    ),
    Student(
      rollNo: '005',
      name: 'Emma Thompson',
      department: 'Physics',
      semester: 2,
    ),
    Student(
      rollNo: '006',
      name: 'Michael Clark',
      department: 'Chemistry',
      semester: 3,
    ),
    Student(
      rollNo: '007',
      name: 'Olivia White',
      department: 'Biology',
      semester: 1,
    ),
    Student(
      rollNo: '008',
      name: 'David Lee',
      department: 'Mathematics',
      semester: 2,
    ),
    Student(
      rollNo: '009',
      name: 'Sophia Garcia',
      department: 'History',
      semester: 3,
    ),
    Student(
      rollNo: '010',
      name: 'James Martinez',
      department: 'English',
      semester: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Full Record',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: DataTable(
              columnSpacing: 20,
              columns: [
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'RollNo.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Department',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Semester',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: students.map((student) {
                return DataRow(
                  cells: [
                    DataCell(Text(
                      student.name,
                      style: TextStyle(color: Colors.white),
                    )),
                    DataCell(Text(
                      student.rollNo,
                      style: TextStyle(color: Colors.white),
                    )),
                    DataCell(Text(
                      dapartment,
                      style: TextStyle(color: Colors.white),
                    )),
                    DataCell(Text(
                      semester,
                      style: TextStyle(color: Colors.white),
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
