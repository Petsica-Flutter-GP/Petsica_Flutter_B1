import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:petsica/core/constants.dart';
import 'package:petsica/features/chatBoot/views/chat_boot_onboarding_view.dart';
import 'package:petsica/features/community/views/adoption_view.dart';
import 'package:petsica/features/community/views/clinic_view.dart';
import 'package:petsica/features/community/views/home_page.dart';
import 'package:petsica/features/community/views/mating_view.dart';
import 'package:petsica/features/community/views/sitter_view.dart';
import 'package:petsica/features/reminder/reminder_view.dart';
import 'package:petsica/features/store/widgets/store_view_body.dart';

// Placeholder pages for navigation (replace with your actual pages)
class PlaceholderPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Pet Home')), body: const Center(child: Text('Pet Home')));
  }
}

class PlaceholderPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Store')), body: const Center(child: Text('Store')));
  }
}

class PlaceholderPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Alarm/Reminder')), body: const Center(child: Text('Alarm/Reminder')));
  }
}

class PlaceholderPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Clinics')), body: const Center(child: Text('Clinics')));
  }
}

class PlaceholderPage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Chat Bot')), body: const Center(child: Text('Chat Bot')));
  }
}

class PlaceholderPageSub1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Pet Adoption')), body: const Center(child: Text('Pet Adoption')));
  }
}

class PlaceholderPageSub2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Pet Mating')), body: const Center(child: Text('Pet Mating')));
  }
}

class PlaceholderPageSub3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Pet Sitter')), body: const Center(child: Text('Pet Sitter')));
  }
}

class ReusableFAB extends StatelessWidget {
  const ReusableFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: kBurgColor,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.grey[700],
      overlayColor: Colors.black.withOpacity(0.4),
      spacing: 12,
      childPadding: const EdgeInsets.all(8),
      child: const Icon(Icons.menu),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: kBurgColor,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.store),
          label: 'Store',
          backgroundColor: kBurgColor,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  const StoreViewBody()),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.alarm),
          label: 'Reminder',
          backgroundColor: kBurgColor,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  ReminderApp()),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.chat),
          label: 'Chat Bot',
          backgroundColor: kBurgColor,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatBootOnboardingView()),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.local_hospital),
          label: 'Clinics',
          backgroundColor: kBurgColor,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ClinicsPage()),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.pets),
          label: 'Pet Adoption',
          backgroundColor: kBurgColor,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PetAdoptionPage()),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.favorite),
          label: 'Pet Mating',
          backgroundColor: kBurgColor,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PetMatingPage()),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.person),
          label: 'Pet Sitter',
          backgroundColor: kBurgColor,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PetSitterPage()),
            );
          },
        ),
      ],
    );
  }
}