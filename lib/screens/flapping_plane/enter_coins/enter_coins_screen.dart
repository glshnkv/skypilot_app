import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skypilot_app/router/router.dart';
import 'package:skypilot_app/screens/flapping_plane/models/plane_model.dart';
import 'package:skypilot_app/theme/colors.dart';
import 'package:skypilot_app/widgets/action_button_widget.dart';

@RoutePage()
class EnterCoinsScreen extends StatefulWidget {
  final PlaneModel plane;

  const EnterCoinsScreen({super.key, required this.plane});

  @override
  State<EnterCoinsScreen> createState() => _EnterCoinsScreenState();
}

class _EnterCoinsScreenState extends State<EnterCoinsScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        centerTitle: true,
        leadingWidth: 110,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              context.router.pop();
            },
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new, color: AppColors.blue),
                SizedBox(width: 5),
                Text(
                  'Back',
                  style: TextStyle(
                    color: AppColors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flapping Plane',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'To start the game, enter the number of coins you want to accumulate.',
                style: TextStyle(
                  color: AppColors.white40,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Goal coins',
                style: TextStyle(
                  color: AppColors.white40,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white8,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActionButtonWidget(
          text: 'Start',
          width: 350,
          onTap: () {
            if (_controller.text.isNotEmpty) {
              context.router.push(FlappingPlaneGameRoute(
                  plane: widget.plane, coins: int.parse(_controller.text)));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.blue,
                  content: Text(
                    'Firstly, enter goal coins!',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              );
            }
          }),
    );
  }
}
