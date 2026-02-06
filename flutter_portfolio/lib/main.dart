import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alishba Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1a2b48),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFe69138),
          brightness: Brightness.dark,
          secondary: const Color(0xFFe69138),
        ),
        textTheme: GoogleFonts.outfitTextTheme(
          ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendEmail() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String message = _messageController.text;

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'alyshbaaleem@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Project Inquiry from $name',
        'body': 'Name: $name\nEmail: $email\n\nMessage:\n$message',
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email client')),
      );
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0d162a),
      drawer: isMobile ? _buildMobileDrawer() : null,
      appBar: isMobile ? AppBar(
        backgroundColor: const Color(0xFF0d162a).withOpacity(0.9),
        elevation: 0,
        title: Text(
          'ALISHBA',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFe69138),
          ),
        ),
        actions: [],
      ) : null,
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -200,
            right: -200,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFe69138).withOpacity(0.1),
              ),
            ).animate().fadeIn(duration: 2.seconds),
          ),
          
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(isMobile),
                _buildAboutSection(isMobile),
                _buildProjectSection(isMobile),
                _buildContactSection(isMobile),
                const SizedBox(height: 50), // Spacing after contact
              ],
            ),
          ),

          // Custom Navbar (Desktop Only)
          if (!isMobile)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildNavbar(),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF0d162a),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF1a2b48), const Color(0xFF0d162a)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFe69138), width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.person, size: 40, color: Color(0xFFe69138)),
                  ),
                ),
                const SizedBox(height: 15),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFe69138), Color(0xFFfff5e1)],
                  ).createShader(bounds),
                  child: Text(
                    'ALISHBA',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _drawerNavItem('Home', Icons.home_filled, () => _scrollToSection(_heroKey)),
          _drawerNavItem('About Me', Icons.person_outline, () => _scrollToSection(_aboutKey)),
          _drawerNavItem('Projects', Icons.layers_outlined, () => _scrollToSection(_projectKey)),
          _drawerNavItem('Contact', Icons.email_outlined, () => _scrollToSection(_contactKey)),
          
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "© 2024 Alishba\nDesigned with Flutter",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white24, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerNavItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFe69138)),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
      onTap: () {
        Navigator.pop(context); // Close drawer
        onTap();
      },
    );
  }

  Widget _buildNavbar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF0d162a).withOpacity(0.7),
            border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
          ),
          child: Row(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFe69138), Color(0xFFfff5e1)],
                ).createShader(bounds),
                child: Text(
                  'ALISHBA',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              _navItem('Home', () => _scrollToSection(_heroKey)),
              _navItem('About', () => _scrollToSection(_aboutKey)),
              _navItem('Projects', () => _scrollToSection(_projectKey)),
              _navItem('Contact', () => _scrollToSection(_contactKey)),
              const SizedBox(width: 20),
              _buildHireButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHireButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFe69138), Color(0xFFffba60)]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: const Color(0xFFe69138).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 5)),
          ],
        ),
        child: const Text(
          'Hire Me',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 1.5.seconds);
  }

  Widget _navItem(String title, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      key: _heroKey,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated Background Elements
          // Animated Background Elements (Desktop Only)
          if (!isMobile) ...[
            Positioned(
              left: 50,
              top: 100,
              child: Container(
                width: 20, height: 20,
                decoration: const BoxDecoration(color: Color(0xFFe69138), shape: BoxShape.circle),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(end: const Offset(2, 2), duration: 2.seconds).fadeOut(duration: 2.seconds),
            ),
            Positioned(
              right: 100,
              bottom: 150,
              child: Container(
                width: 15, height: 15,
                decoration: BoxDecoration(border: Border.all(color: Colors.white24, width: 2), shape: BoxShape.circle),
              ).animate(onPlay: (c) => c.repeat()).moveY(begin: 0, end: -50, duration: 4.seconds),
            ),
          ],

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFe69138), Color(0xFFffba60), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    "ALISHBA",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: isMobile ? 60 : 140, // Base size, FittedBox will scale it down if needed
                      fontWeight: FontWeight.w900,
                      color: Colors.white, // Required for ShaderMask
                      letterSpacing: -4,
                      height: 0.9,
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                 .moveY(begin: -5, end: 5, duration: 3.seconds, curve: Curves.easeInOut),
              ),
              
              const SizedBox(height: 30),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white12),
                  color: Colors.white.withOpacity(0.03),
                ),
                child: Text(
                  "FLUTTER ENGINEER & UI DESIGNER",
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 14 : 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 4,
                    color: Colors.white70,
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

              const SizedBox(height: 30),
              
              SizedBox(
                width: isMobile ? double.infinity : 700,
                child: Text(
                  "Creating high-performance, beautiful mobile and web applications with Flutter. Focused on clean architecture and premium user experiences.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    color: Colors.white60,
                    height: 1.8,
                    fontFamily: GoogleFonts.outfit().fontFamily,
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms),
              
              const SizedBox(height: 50),
              
              isMobile 
              ? Column(
                  children: [
                    _heroButton("VIEW WORK", () => _scrollToSection(_projectKey), true),
                    const SizedBox(height: 20),
                    _heroButton("CONTACT ME", () => _scrollToSection(_contactKey), false),
                  ],
                )
              : Row(
                  children: [
                    _heroButton("VIEW WORK", () => _scrollToSection(_projectKey), true),
                    const SizedBox(width: 25),
                    _heroButton("ABOUT ME", () => _scrollToSection(_aboutKey), false),
                  ],
                ),
            ],
          ),
          
          Positioned(
            bottom: 40,
            child: Column(
              children: [
                const Text("SCROLL DOWN", style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 2)),
                const SizedBox(height: 10),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white24),
              ],
            ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: 0, end: 10, duration: 1.seconds),
          )
        ],
      ),
    );
  }

  Widget _heroButton(String text, VoidCallback onTap, bool isPrimary) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            gradient: isPrimary 
              ? const LinearGradient(colors: [Color(0xFFe69138), Color(0xFFffba60)])
              : null,
            color: isPrimary ? null : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
            border: isPrimary ? null : Border.all(color: Colors.white24, width: 1),
            boxShadow: isPrimary ? [
              BoxShadow(
                color: const Color(0xFFe69138).withOpacity(0.4), 
                blurRadius: 20, 
                offset: const Offset(0, 8)
              )
            ] : null,
          ),
          child: Text(
            text, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.white,
              letterSpacing: 1.2,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 1.2.seconds).slideX(begin: isPrimary ? -0.2 : 0.2);
  }


  Widget _buildAboutSection(bool isMobile) {
    return Container(
      key: _aboutKey,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: isMobile ? 50 : 100),
      color: const Color(0xFF1a2b48).withOpacity(0.5),
      child: Column(
        children: [
          _sectionTitle("Introduction", "Who I Am"),
          const SizedBox(height: 60),
          isMobile 
            ? Column(children: _aboutContent(isMobile))
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: _aboutContent(isMobile)),
        ],
      ),
    );
  }

  List<Widget> _aboutContent(bool isMobile) {
    Widget bio = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Software Engineering Student & Flutter Enthusiast",
          style: GoogleFonts.playfairDisplay(
            fontSize: 32, 
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          "Hi, I’m Alishba, a motivated Software Engineering student with hands-on experience in marketing and a strong interest in mobile app and web development.\n\nI have practical experience as a Brand Ambassador at Aptech, where I worked on marketing, communication, and brand promotion. This role helped me understand how technology, users, and business goals connect in the real world.\n\nAlongside marketing, I am actively learning and building skills in Flutter & Dart for mobile app development and PHP for web development. While my professional experience so far is in marketing, I am focused on growing as a developer through continuous learning, practice, and personal projects.",
          style: TextStyle(fontSize: 16, height: 1.8, color: Colors.white70),
        ),
      ],
    );

    Widget skills = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile) const SizedBox(height: 40),
        Text("MY SKILL SET", style: GoogleFonts.outfit(color: const Color(0xFFe69138), letterSpacing: 2, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        _skillItem("Marketing & Branding", "Aptech Brand Ambassador Experience"),
        _skillItem("Flutter & Dart", "Cross-Platform App Development (Learning)"),
        _skillItem("Mobile App Development", "Focusing on UI/UX & Logic"),
        _skillItem("Web Development", "PHP & Modern Web Technologies"),
        _skillItem("UI / UX Understanding", "User-Focused Mindset"),
        _skillItem("Problem Solving", "Continuous Learning & Adaptability"),
      ],
    );

    if (isMobile) {
      return [bio, skills];
    } else {
      return [
        Expanded(flex: 4, child: bio),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: skills),
      ];
    }
  }

  Widget _skillItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFFe69138), size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
  }

  Widget _buildProjectSection(bool isMobile) {
    final projects = [
      {'title': 'NeonFit App', 'image': 'assets/projects/f1.png', 'cat': 'Flutter Mobile'},
      {'title': 'Fintura Dashboard', 'image': 'assets/projects/f2.png', 'cat': 'Flutter Web'},
      {'title': 'E-Commerce Platform', 'image': 'assets/projects/project1.png', 'cat': 'Social App'},
      {'title': 'Creative Portfolio', 'image': 'assets/projects/project2.png', 'cat': 'Design'},
    ];

    return Container(
      key: _projectKey,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: isMobile ? 50 : 100),
      child: Column(
        children: [
          _sectionTitle("Projects", "Recent Flutter Masterpieces"),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              return _projectCard(projects[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _projectCard(Map<String, String> project) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 10))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Image with zoom effect on hover (simulated with scale)
            Positioned.fill(
              child: Image.asset(project['image']!, fit: BoxFit.cover)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 5.seconds),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent, 
                      const Color(0xFF0d162a).withOpacity(0.6),
                      const Color(0xFF0d162a).withOpacity(0.9)
                    ],
                    stops: const [0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 30,
              left: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFe69138),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      project['cat']!.toUpperCase(), 
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    project['title']!, 
                    style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.bold, height: 1.1),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("View Project", style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward, color: Color(0xFFe69138), size: 16),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn().slideY(begin: 0.1),
    );
  }


  Widget _buildContactSection(bool isMobile) {
    return Container(
      key: _contactKey,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: isMobile ? 50 : 100),
      child: Column(
        children: [
          _sectionTitle("Contact", "Let's Build Something Great"),
          const SizedBox(height: 60),
          isMobile 
            ? Column(children: _contactContent(isMobile))
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: _contactContent(isMobile)),
        ],
      ),
    );
  }

  List<Widget> _contactContent(bool isMobile) {
    Widget contactInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Get In Touch", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text("Have a project in mind? Let's discuss how we can turn your vision into a high-performance Flutter application."),
        const SizedBox(height: 40),
        _contactItem(Icons.email, "alyshbaaleem@gmail.com"),
        _contactItem(Icons.phone, "+92 312 0347329"),
        _contactItem(Icons.location_on, "Karachi, Pakistan"),
        const SizedBox(height: 20),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse('https://www.linkedin.com/in/aliishba-aleem-flutter-developer-details-skills?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch \$url');
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF0077b5),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0077b5).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.link, color: Colors.white),
                  SizedBox(width: 10),
                  Text("Connect on LinkedIn", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          ),
        ).animate().fadeIn(delay: 1.seconds),
      ],
    );

    Widget contactForm = Column(
      children: [
        _textField("Name", controller: _nameController),
        const SizedBox(height: 20),
        _textField("Email", controller: _emailController),
        const SizedBox(height: 20),
        _textField("Message", controller: _messageController, maxLines: 5),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _sendEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFe69138),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("SEND MESSAGE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );

    if (isMobile) {
      return [
        contactInfo,
        const SizedBox(height: 50),
        contactForm,
      ];
    } else {
      return [
        Expanded(child: contactInfo),
        const SizedBox(width: 100),
        Expanded(child: contactForm),
      ];
    }
  }

  Widget _contactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
            child: Icon(icon, color: const Color(0xFFe69138)),
          ),
          const SizedBox(width: 20),
          Text(text, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _textField(String hint, {int maxLines = 1, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), 
          borderSide: const BorderSide(color: Color(0xFFe69138), width: 2)
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }

  Widget _sectionTitle(String subtitle, String title) {
    return Column(
      children: [
        Text(
          subtitle.toUpperCase(), 
          style: GoogleFonts.outfit(
            color: const Color(0xFFe69138), 
            letterSpacing: 8, 
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title, 
          style: GoogleFonts.playfairDisplay(
            fontSize: MediaQuery.of(context).size.width < 900 ? 32 : 45, 
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 25),
        Container(
          width: 60, 
          height: 3, 
          decoration: BoxDecoration(
            color: const Color(0xFFe69138), 
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFe69138).withOpacity(0.5),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1);
  }

}
