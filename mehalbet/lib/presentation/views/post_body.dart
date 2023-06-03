import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/application/job/bloc/job_event.dart';
import 'package:jobportal/application/job/bloc/job_state.dart';
import 'package:intl/intl.dart'; 


class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDeadline;
  final List<String> _categories = [
    'TECH',
    'BUSINESS',
    'ART',
    'CONSTRUCTION',
    'EDUCATION',
    'OTHER'
  ];

  String? categorySelected;
  // String selectedRole = Roles.Company;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
final TextEditingController _locationController = TextEditingController();
Future<void> _selectDeadline(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 5),
  );

  if (picked != null && picked != selectedDeadline) {
    setState(() {
      selectedDeadline = picked;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Post a new Job",
            style: TextStyle(
              fontSize: 33.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          DropdownButton<String>(
            value: categorySelected,
            isExpanded: true,
            hint: const Text('Choose Job Category'),
            items: _categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                categorySelected = value!;
              });
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            key:Key("title"),
            controller: _titleController,
            decoration:
                const InputDecoration(labelText: 'Title'),
            validator: (String? value) {
             if (value == null || value.isEmpty) {
                return 'Please enter a brief job description';
              }
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            key:Key("description"),
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a brief job description';
              }
              return null;
            },
          ),
         

GestureDetector(
  onTap: () {
    _selectDeadline(context);
  },
  child: AbsorbPointer(
    child: TextFormField(
      decoration: InputDecoration(
        labelText: 'Deadline',
      ),
      // Use the selectedDeadline variable to display the chosen date
      initialValue: selectedDeadline != null
          ? DateFormat('yyyy-MM-dd').format(selectedDeadline!)
          : null,
    ),
  ),
),


const SizedBox(
  height: 20.0,
),

TextFormField(
  key: Key("location"),
  controller: _locationController,
  decoration: InputDecoration(labelText: 'Location'),
  validator: (String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a location';
    }
    return null;
  },
),





          const SizedBox(
            height: 20,
          ),
         
          BlocBuilder<JobBloc, JobsState>(
            builder: (context, state) {
            print(state.postjob);
              if(state.postjob== JobsStatus.requestInProgress){
                  return const CircularProgressIndicator();}
              else if(state.postjob == JobsStatus.NetworkFailure){
                return const Text("Network problem , please try again");
              }else if(state.postjob == JobsStatus.requestSuccess){
                return Text("Posted job successfuly!" , style: TextStyle(color: Colors.green),);
                
              }
              return   ElevatedButton(
                    
                      style: ButtonStyle(
                        elevation:MaterialStateProperty.all(16),
                      ),
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(15.0),
                        child: const Center(
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                         Map<String , String> data = {
                          "description" : _descriptionController.text,
                          "title" :  _titleController.text,
                          "department" :  categorySelected!,
                           "deadline": selectedDeadline != null
                     ? DateFormat('yyyy-MM-dd').format(selectedDeadline!) : '',// Add the deadline value to the data map
                             "location": _locationController.text
                         };
                          BlocProvider.of<JobBloc>(context).add(
                            PostJobRequested(jobInput: data),
                          );
                        }
                      },
                    );
                 
            },
          )
        ],
      ),
    );
  }
}