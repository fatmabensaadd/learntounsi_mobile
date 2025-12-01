import 'package:flutter/material.dart';
import '../widgets/top_navbar.dart';
import 'terminer.dart';

class PageCours extends StatelessWidget {
  final String matiere;
  final String cours;

  const PageCours({
    super.key,
    required this.matiere,
    required this.cours,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF234138),
        title: Text(cours),
      ),

      body: Column(
        children: [
          const TopNavigationBar(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Bienvenue dans le cours :",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cours,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF234138),
                    ),
                  ),
                  const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC2A83E),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              TerminerPage(matiere: matiere, cours: cours),
                        ),
                      );
                    },
                    child: const Text(
                      "Commencer le Quiz",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
