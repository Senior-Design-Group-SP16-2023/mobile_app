import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/views/widgets/backgrounds/background.dart';
import 'package:senior_design/views/widgets/backgrounds/background_name.dart';
import 'package:senior_design/view_models/user_view_model.dart';

class DoctorAccountView extends HookWidget {
  const DoctorAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final hospitalNameController = useTextEditingController();
    final addressController = useTextEditingController();
    final cityController = useTextEditingController();
    final stateController = useTextEditingController();
    final zipCodeController = useTextEditingController();
    final floorRoomController = useTextEditingController();
    final specializationController = useTextEditingController();

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
        imagePath: BackgroundName.loginBackground,
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
                  buildTextField(hospitalNameController, 'Hospital Name',
                      TextInputType.text),
                  buildTextField(addressController, 'Address',
                      TextInputType.streetAddress),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: buildTextField(
                            cityController, 'City', TextInputType.text),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: buildTextField(
                            stateController, 'State', TextInputType.text),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: buildTextField(zipCodeController, 'Zip Code',
                            TextInputType.number),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: buildTextField(floorRoomController, 'Floor/Room',
                            TextInputType.text),
                      ),
                    ],
                  ),
                  buildTextField(specializationController, 'Specialization',
                      TextInputType.text),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      // Logic to handle doctor information submission
                      userViewModel.setDoctorInfo(
                        hospitalNameController.text,
                        addressController.text,
                        cityController.text,
                        stateController.text,
                        zipCodeController.text,
                        floorRoomController.text,
                        specializationController.text,
                      );
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
