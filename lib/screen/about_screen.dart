import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // Helper method to handle external links
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // Helper method to handle Email
  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'tmk.muse@gmail.com',
    );
    await launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Matches your Table/Home theme
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "လွင်ႈၽူႈၶူင်သၢင်ႈ", // "About Us"
          style: TextStyle(
            fontFamily: "AJ",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Top Header Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Logo with soft glow
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/tmklogo.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "ထုင်ႉမၢဝ်းၶမ်း",
                  style: TextStyle(
                    fontFamily: "AJ",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),

          // Scrollable Contact Cards
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600), // Desktop Optimization
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      _buildContactCard(
                        icon: FontAwesomeIcons.envelope,
                        iconColor: Colors.redAccent,
                        label: "Email",
                        value: "tmk.muse@gmail.com",
                        onTap: _sendEmail,
                      ),
                      _buildContactCard(
                        icon: FontAwesomeIcons.facebook,
                        iconColor: const Color(0xFF1877F2),
                        label: "Facebook",
                        value: "ထုင်ႉမၢဝ်းၶမ်း",
                        onTap: () => _launchUrl("https://www.facebook.com/100377671433172"),
                      ),
                      _buildContactCard(
                        icon: FontAwesomeIcons.github,
                        iconColor: const Color(0xFF24292E),
                        label: "GitHub",
                        value: "Get Source Code",
                        onTap: () => _launchUrl("https://github.com/SaingHmineTun/TMKTaiLeConverter"),
                      ),
                      _buildContactCard(
                        icon: FontAwesomeIcons.earthAsia,
                        iconColor: const Color(0xFF34A853),
                        label: "Website",
                        value: "Visi developer website",
                        onTap: () => _launchUrl("https://www.saimao.top"),
                      ),

                      const SizedBox(height: 40),
                      const Text(
                        "App Version: 1.0.0",
                        style: TextStyle(
                          fontFamily: "AJ",
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.blueAccent.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon Background
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: FaIcon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 20),

                // Text Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontFamily: "AJ",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "AJ",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                ),

                // Hint Icon
                const Icon(
                  Icons.open_in_new_rounded,
                  size: 16,
                  color: Colors.black12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}