import 'package:appekrili/request.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ItemDetailsPage extends StatelessWidget {
  final Map<String, String> item;

  const ItemDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A45), // Matching background color
      appBar: AppBar(
        title: Text(
          item["name"] ?? "Details",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0A0A45),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // Adds padding around content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           

            // Subtitle
            Text(
              item["subtitle"]!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Price
            Text(
              "Price: ${item["price"]}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 10),

            // Details Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A5A), // Solid dark blue for contrast
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Details: ${item["details"]}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Localisation
            _buildDetailRow("Localisation:", item["Localisation"]!, Colors.orangeAccent),

            // Phone Number
            _buildDetailRow("Phone number:", item["phone"]!, Colors.lightBlueAccent),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
            
            color:  Colors.orangeAccent,
            textColor: Colors.white,
            onPressed: (){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.rightSlide,
              title: 'Confirm your Command',
              desc: 'Are you sure you want to command these machine?',
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => request()),
    );
              },
              )..show();
              
            },child: Text('Command',style: TextStyle(fontSize: 40),),),
          )
          
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
