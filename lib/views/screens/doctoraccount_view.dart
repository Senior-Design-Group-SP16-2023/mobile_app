import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/auth_view_model.dart';
import 'package:senior_design/views/widgets/background.dart';

class DoctorAccountView extends StatefulWidget {
  const DoctorAccountView({Key? key}) : super(key: key);

  @override
  State<DoctorAccountView> createState() => _DoctorAccountViewState();
}

class _DoctorAccountViewState extends State<DoctorAccountView> {
  late TextEditingController _hospitalNameController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;
  late TextEditingController _floorRoomController;
  late TextEditingController _specializationController;

  @override
  void initState() {
    super.initState();
    _hospitalNameController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _zipCodeController = TextEditingController();
    _floorRoomController = TextEditingController();
    _specializationController = TextEditingController();
  }

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _floorRoomController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true, // Make body extend behind AppBar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Back'), // Optionally, you can also add a title here
        // align the title to the right of the icon
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent, // Ensure AppBar is transparent
        foregroundColor: Colors.black, // Set icon color
      ),
      body: BackgroundImage(
        child: Padding(
          padding: const EdgeInsets.only(
              top: kToolbarHeight + 20.0,
              left: 20.0,
              right: 20.0,
              bottom: 20.0),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100.0), // Space at the top
                  const Text(
                    'Enter Doctor Information',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  buildTextField(_hospitalNameController, 'Hospital Name',
                      TextInputType.text),
                  buildTextField(_addressController, 'Address',
                      TextInputType.streetAddress),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: buildTextField(
                            _cityController, 'City', TextInputType.text),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: buildTextField(
                            _stateController, 'State', TextInputType.text),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: buildTextField(_zipCodeController, 'Zip Code',
                            TextInputType.number),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: buildTextField(_floorRoomController,
                            'Floor/Room', TextInputType.text),
                      ),
                    ],
                  ),
                  buildTextField(_specializationController, 'Specialization',
                      TextInputType.text),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      // Logic to handle doctor information submission
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Create Account',
                          style: TextStyle(fontSize: 18)),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0), // Space at the bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String labelText,
    TextInputType keyboardType, {
    int? maxLines = 1,
  }) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}