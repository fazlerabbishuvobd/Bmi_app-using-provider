import 'package:bmi_calculator_app/contoller/bmi_provider.dart';
import 'package:bmi_calculator_app/screens/select_height.dart';
import 'package:bmi_calculator_app/widgets/custom_button.dart';
import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String gender;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: Text(
          AppLocalizations.of(context)!.genderChoose,
          style: customBodyText(Colors.white, 22, FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppBarTheme
            .of(context)
            .backgroundColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<BMIProvider>(
            builder: (context, bmiProvider, child) =>
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    /// Image
                    SizedBox(
                      height: height * 0.50,
                      width: width,
                      child: Image.asset(bmiProvider.isMale ? 'assets/images/man.png' : 'assets/images/woman.png'),
                    ),

                    // Male Female Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Male Button
                        customButton(
                            onPressed: () {
                              bmiProvider.getGender();
                            },
                            buttonTxt: AppLocalizations.of(context)!.male,
                            icons: Icons.male,
                            color: bmiProvider.isMale ? Colors.blue : Colors
                                .white,
                            width: 150,
                            height: 56),

                        // Female Button
                        customButton(
                            onPressed: () {
                              bmiProvider.getGender();
                            },
                            buttonTxt: AppLocalizations.of(context)!.female,
                            icons: Icons.female,
                            color: bmiProvider.isMale ? Colors.white : Colors
                                .pinkAccent,
                            width: 150,
                            height: 56
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Next Button
                    customButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                              SelectHeight(gender: bmiProvider.isMale ? 'Male' : 'Female',))
                          );

                          // Store Gender
                          final sharedPreferences = await SharedPreferences.getInstance();
                          await sharedPreferences.setString('gender', bmiProvider.isMale ? 'Male' : 'Female');
                        },
                        buttonTxt: AppLocalizations.of(context)!.nextButton,
                        icons: Icons.skip_next,
                        height: 56,
                        width: width,
                        color: Colors.amber
                    )
                  ],
                ),
          ),
        ),
      ),
    );
  }

}

