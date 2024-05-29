import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:scavenger_app/Screens/main_sceens/adding_new_classes.dart';
import 'package:scavenger_app/Screens/main_sceens/semesters_screen.dart';
import 'package:scavenger_app/bloc/DepartmentId-cubit/department_cubit.dart';
import 'package:scavenger_app/bloc/DepartmentId-cubit/department_state.dart';
import 'package:scavenger_app/utils/widgets/class_container.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DepartmentCubit>().getDepartment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Departments",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<DepartmentCubit, DepartmentState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 0.8),
                      ),
                      hintText: 'Search Classes',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30.0,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (state is DepartmentLoadingState)
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                else if (state is DepartmentLoadedState)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.Department.length,
                      itemBuilder: (context, index) {
                        final department = state.Department[index];
                        List<dynamic> semesters = department['semesters'];

                        return GestureDetector(
                          onTap: () {
                            // Get.to(AddingStudentScreen(
                            //   department: department['department'],
                            //   semester: department['semesters']['semester'],
                            //   classesId: department['id'],
                            //   // rollNo: rollNo,
                            // ));

                            Get.to(SemesterScreen(
                              deptId: department['departmentId'],
                              semesters: semesters,
                              department: department['department'],
                              // rollNo: rollNo,
                            ));
                          },
                          child: ClassContainer(
                            departmentName: department['department'],
                          ),
                        );
                      },
                    ),
                  )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(AddingNewClasses());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
